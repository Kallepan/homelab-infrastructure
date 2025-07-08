locals {
  all_bucket_names = toset(flatten([for b in var.bucket_configurations : b.buckets]))
  bucket_map = { for b in var.bucket_configurations : b.user_name => b }
}

resource "minio_s3_bucket" "buckets" {
  for_each = local.all_bucket_names
  bucket   = each.value
  acl      = "private"
}

resource "minio_iam_user" "users" {
  for_each = local.bucket_map

  name       = each.value.user_name
}

resource "minio_iam_group" "groups" {
  for_each = local.bucket_map

  name = each.value.group_name
}

resource "minio_iam_group_membership" "group_memberships" {
  for_each = local.bucket_map

  name  = "${each.value.group_name}_membership"
  users = [minio_iam_user.users[each.key].name]
  group = minio_iam_group.groups[each.key].name
}

resource "minio_accesskey" "access_keys" {
  for_each = local.bucket_map

  user       = minio_iam_user.users[each.key].name
  access_key = each.value.access_key
  secret_key = each.value.secret_key
  status     = "enabled"
}

resource "minio_iam_policy" "policies" {
  for_each = local.bucket_map

  name   = "${each.value.group_name}_policy"
  policy = each.value.policy
}

resource "minio_iam_group_policy_attachment" "name" {
  for_each = local.bucket_map
  policy_name = minio_iam_policy.policies[each.key].id
  group_name  = minio_iam_group.groups[each.key].name
}
