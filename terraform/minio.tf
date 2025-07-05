### Argo Workflows ###
resource "minio_iam_group" "argo" {
  name = "argo"
}

resource "minio_iam_user" "argo" {
  name = "argo"
}

resource "minio_accesskey" "argo" {
  user       = minio_iam_user.argo.name
  access_key = var.bucket_argo_access_key
  secret_key = var.bucket_argo_secret_key
  status     = "enabled"
}

resource "minio_iam_group_membership" "argo_group_membership" {
  name  = "argo_group_membership"
  users = [minio_iam_user.argo.name]
  group = minio_iam_group.argo.name
}

resource "minio_iam_policy" "argo_policy" {
  name   = "argo_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": [
        "arn:aws:s3:::argo-workflows-artifacts"
    ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": [
        "arn:aws:s3:::argo-workflows-artifacts/*"
     ]
    }
  ]
}
EOF
}

resource "minio_iam_group_policy_attachment" "argo_policy_attachment" {
  policy_name = minio_iam_policy.argo_policy.id
  group_name  = minio_iam_group.argo.name
}

resource "minio_s3_bucket" "argo_workflows_bucket" {
  bucket = "argo-workflows-artifacts"
  acl    = "private"
}

### Backups ###
resource "minio_iam_group" "backups" {
  name = "backups"
}

resource "minio_iam_user" "backups" {
  name = "backups"
}

resource "minio_accesskey" "backups" {
  user       = minio_iam_user.backups.name
  access_key = var.bucket_backups_access_key
  secret_key = var.bucket_backups_secret_key
  status     = "enabled"
}

resource "minio_iam_group_membership" "backups_group_membership" {
  name  = "backups_group_membership"
  users = [minio_iam_user.backups.name]
  group = minio_iam_group.backups.name
}

resource "minio_iam_policy" "backups_policy" {
  name   = "backups_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": ["arn:aws:s3:::backups"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": ["arn:aws:s3:::backups/*"]
    }
  ]
}
EOF
}

resource "minio_iam_group_policy_attachment" "backups_policy_attachment" {
  policy_name = minio_iam_policy.backups_policy.id
  group_name  = minio_iam_group.backups.name
}

resource "minio_s3_bucket" "backups_bucket" {
  bucket = "backups"
  acl    = "private"
}

### Runner ###
resource "minio_iam_group" "gitlab_runner" {
  name = "gitlab_runner"
}

resource "minio_iam_user" "gitlab_runner" {
  name = "gitlab_runner"
}

resource "minio_accesskey" "gitlab_runner" {
  user       = minio_iam_user.gitlab_runner.name
  access_key = var.bucket_gitlab_runner_access_key
  secret_key = var.bucket_gitlab_runner_secret_key
  status     = "enabled"
}

resource "minio_iam_group_membership" "gitlab_runner" {
  name  = "gitlab_runner_group_membership"
  users = [minio_iam_user.gitlab_runner.name]
  group = minio_iam_group.gitlab_runner.name
}

resource "minio_iam_policy" "gitlab_runner_policy" {
  name   = "gitlab_runner_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": [
        "arn:aws:s3:::gitlab-runner"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": [
        "arn:aws:s3:::gitlab-runner/*"
      ]
    }
  ]
}
EOF
}

resource "minio_iam_group_policy_attachment" "gitlab_runner_policy_attachment" {
  policy_name = minio_iam_policy.gitlab_runner_policy.id
  group_name  = minio_iam_group.gitlab_runner.name
}

resource "minio_s3_bucket" "gitlab_runner_bucket" {
  bucket = "gitlab-runner"
  acl    = "private"
}

### Gitlab ###

resource "minio_iam_group" "gitlab" {
  name = "gitlab"
}

resource "minio_iam_user" "gitlab" {
  name = "gitlab"
}

resource "minio_accesskey" "gitlab" {
  user       = minio_iam_user.gitlab.name
  access_key = var.bucket_gitlab_access_key
  secret_key = var.bucket_gitlab_secret_key
  status     = "enabled"
}

resource "minio_iam_group_membership" "gitlab_group_membership" {
  name  = "gitlab_group_membership"
  users = [minio_iam_user.gitlab.name]
  group = minio_iam_group.gitlab.name

}

resource "minio_iam_policy" "gitlab_policy" {
  name   = "gitlab_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": [
        "arn:aws:s3:::gitlab-artifacts",
        "arn:aws:s3:::gitlab-backups",
        "arn:aws:s3:::gitlab-backups-tmp",
        "arn:aws:s3:::gitlab-mr-diffs",
        "arn:aws:s3:::gitlab-lfs",
        "arn:aws:s3:::gitlab-uploads",
        "arn:aws:s3:::gitlab-packages",
        "arn:aws:s3:::gitlab-dependency-proxy",
        "arn:aws:s3:::gitlab-terraform-state",
        "arn:aws:s3:::gitlab-ci-secure-files",
        "arn:aws:s3:::gitlab-pages",
        "arn:aws:s3:::gitlab-registry-storage"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": [
        "arn:aws:s3:::gitlab-artifacts/*",
        "arn:aws:s3:::gitlab-backups/*",
        "arn:aws:s3:::gitlab-backups-tmp/*",
        "arn:aws:s3:::gitlab-mr-diffs/*",
        "arn:aws:s3:::gitlab-lfs/*",
        "arn:aws:s3:::gitlab-uploads/*",
        "arn:aws:s3:::gitlab-packages/*",
        "arn:aws:s3:::gitlab-dependency-proxy/*",
        "arn:aws:s3:::gitlab-terraform-state/*",
        "arn:aws:s3:::gitlab-ci-secure-files/*",
        "arn:aws:s3:::gitlab-pages/*",
        "arn:aws:s3:::gitlab-registry-storage/*"
      ]
    }
  ]
}
EOF
}

resource "minio_iam_group_policy_attachment" "gitlab_policy_attachment" {
  policy_name = minio_iam_policy.gitlab_policy.id
  group_name  = minio_iam_group.gitlab.name
}

resource "minio_s3_bucket" "gitlab_artifacts_bucket" {
  bucket = "gitlab-artifacts"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_backups_bucket" {
  bucket = "gitlab-backups"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_backups_tmp_bucket" {
  bucket = "gitlab-backups-tmp"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_mr_diffs_bucket" {
  bucket = "gitlab-mr-diffs"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_lfs_bucket" {
  bucket = "gitlab-lfs"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_uploads_bucket" {
  bucket = "gitlab-uploads"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_packages_bucket" {
  bucket = "gitlab-packages"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_dependency_proxy_bucket" {
  bucket = "gitlab-dependency-proxy"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_terraform_state_bucket" {
  bucket = "gitlab-terraform-state"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_ci_secure_files_bucket" {
  bucket = "gitlab-ci-secure-files"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_pages_bucket" {
  bucket = "gitlab-pages"
  acl    = "private"
}

resource "minio_s3_bucket" "gitlab_registry_storage_bucket" {
  bucket = "gitlab-registry-storage"
  acl    = "private"
}

### Rancher ###
resource "minio_iam_group" "rancher" {
  name = "rancher"
}

resource "minio_iam_user" "rancher" {
  name = "rancher"
}

resource "minio_accesskey" "rancher" {
  user       = minio_iam_user.rancher.name
  access_key = var.bucket_rancher_access_key
  secret_key = var.bucket_rancher_secret_key
  status     = "enabled"
}

resource "minio_iam_group_membership" "rancher_group_membership" {
  name  = "rancher_group_membership"
  users = [minio_iam_user.rancher.name]
  group = minio_iam_group.rancher.name
}

resource "minio_iam_policy" "rancher_policy" {
  name   = "rancher_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": ["arn:aws:s3:::rancher"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": ["arn:aws:s3:::rancher/*"]
    }
  ]
}
EOF
}
resource "minio_iam_group_policy_attachment" "rancher" {
  group_name  = minio_iam_user.rancher.name
  policy_name = minio_iam_policy.rancher_policy.name
}

resource "minio_s3_bucket" "rancher" {
  bucket = "rancher"
  acl    = "private"
}

### Loki ###
resource "minio_iam_group" "loki" {
  name = "loki"
}

resource "minio_iam_user" "loki" {
  name = "loki"
}

resource "minio_accesskey" "loki" {
  user       = minio_iam_user.loki.name
  access_key = var.bucket_loki_access_key
  secret_key = var.bucket_loki_secret_key
  status     = "enabled"
}

resource "minio_iam_group_membership" "loki" {
  name  = "loki_group_membership"
  users = [minio_iam_user.loki.name]
  group = minio_iam_group.loki.name
}

resource "minio_iam_policy" "loki_policy" {
  name   = "loki_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": [
        "arn:aws:s3:::loki-chunks"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
      ],
      "Resource": [
        "arn:aws:s3:::loki-chunks/*"
      ]
    }
  ]
}
EOF
}

resource "minio_iam_group_policy_attachment" "loki" {
  group_name  = minio_iam_user.loki.name
  policy_name = minio_iam_policy.loki_policy.name
}

resource "minio_s3_bucket" "loki_chunks" {
  bucket = "loki-chunks"
  acl    = "private"
}
