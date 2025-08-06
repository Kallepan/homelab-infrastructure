module "minio" {
  source = "./modules/minio"

  bucket_configurations = [
    {
      buckets = ["mattermost"]
      user_name   = "mattermost"
      group_name  = "mattermost"
      access_key  = var.bucket_mattermost_access_key
      secret_key  = var.bucket_mattermost_secret_key
      policy      = <<EOF
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
                "arn:aws:s3:::mattermost"
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
                "arn:aws:s3:::mattermost/*"
            ]
        }
    ]
}
EOF
    },
    {
      buckets = ["argo-workflows-artifacts"]
      user_name   = "argo"
      group_name  = "argo"
      access_key  = var.bucket_argo_access_key
      secret_key  = var.bucket_argo_secret_key
      policy      = <<EOF
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
    },
    {
      buckets = ["backups"]
      user_name   = "backups"
      group_name  = "backups"
      access_key  = var.bucket_backups_access_key
      secret_key  = var.bucket_backups_secret_key
      policy      = <<EOF
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
    },
    {
      buckets = ["gitlab-runner"]
      user_name   = "gitlab_runner"
      group_name  = "gitlab_runner"
      access_key  = var.bucket_gitlab_runner_access_key
      secret_key  = var.bucket_gitlab_runner_secret_key
      policy      = <<EOF
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
    },
    {
      buckets = ["gitlab-artifacts", "gitlab-backups", "gitlab-backups-tmp", "gitlab-mr-diffs", "gitlab-lfs", "gitlab-uploads", "gitlab-packages", "gitlab-dependency-proxy", "gitlab-terraform-state", "gitlab-ci-secure-files", "gitlab-pages", "gitlab-registry-storage"]
      user_name   = "gitlab"
      group_name  = "gitlab"
      access_key  = var.bucket_gitlab_access_key
      secret_key  = var.bucket_gitlab_secret_key
      policy      = <<EOF
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
    },
    {
      buckets = ["loki-chunks"]
      user_name   = "loki"
      group_name  = "loki"
      access_key  = var.bucket_loki_access_key
      secret_key  = var.bucket_loki_secret_key
      policy      = <<EOF
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
    },
    {
      buckets = ["rancher"]
      user_name   = "rancher"
      group_name  = "rancher"
      access_key  = var.bucket_rancher_access_key
      secret_key  = var.bucket_rancher_secret_key
      policy      = <<EOF
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
    },
    {
      buckets = ["mlflow"]
      user_name   = "mlflow"
      group_name  = "mlflow"
      access_key  = var.bucket_mlflow_access_key
      secret_key  = var.bucket_mlflow_secret_key
      policy      = <<EOF
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
      "Resource": ["arn:aws:s3:::mlflow"]
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
      "Resource": ["arn:aws:s3:::mlflow/*"]
    }
  ]
}
EOF
    }
  ]
  minio_user                     = var.minio_user
  minio_password                 = var.minio_password
}
