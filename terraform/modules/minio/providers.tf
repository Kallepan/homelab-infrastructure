terraform {
    required_providers {
        minio = {
            source = "aminueza/minio"
        }
        null = {
            source = "hashicorp/null"
        }
    }
}

provider "minio" {
  minio_server   = "${var.minio_server_hostname}:${var.minio_server_port}"
  minio_region   = "eu-west-1"
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = true
  minio_insecure = true
}
