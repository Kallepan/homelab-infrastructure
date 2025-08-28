locals {
  all_bucket_names = toset(flatten([for b in var.bucket_configurations : b.buckets]))
  bucket_map = { for b in var.bucket_configurations : b.user_name => b }
  
  # Create a map of buckets that have lifecycle policies
  lifecycle_buckets = merge([
    for config in var.bucket_configurations : 
    config.lifecycle_policy != null ? {
      for bucket in config.buckets : bucket => config.lifecycle_policy
    } : {}
  ]...)
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

# Apply lifecycle policies using AWS CLI
resource "null_resource" "lifecycle_policies" {
  for_each = local.lifecycle_buckets
  
  # Ensure buckets are created first
  depends_on = [ minio_s3_bucket.buckets ]
  
  provisioner "local-exec" {
    command = <<-EOT
      aws s3api put-bucket-lifecycle-configuration \
        --endpoint-url ${var.minio_server_protocol}://${var.minio_server_hostname}:${var.minio_server_port} \
        --bucket ${each.key} \
        --lifecycle-configuration '${each.value}' \
        --no-verify-ssl
    EOT
    
    environment = {
      AWS_ACCESS_KEY_ID     = var.minio_user
      AWS_SECRET_ACCESS_KEY = var.minio_password
      AWS_DEFAULT_REGION    = "eu-west-1"
    }
  }
  
  # Trigger re-run when lifecycle policy changes
  triggers = {
    lifecycle_policy = each.value
  }
}
