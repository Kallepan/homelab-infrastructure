resource "kubernetes_secret_v1" "harbor_s3_secret" {
  metadata {
    name      = "harbor-s3-secret"
    namespace = "harbor"
  }

  type = "Opaque"

  data = {
    "REGISTRY_STORAGE_S3_ACCESSKEY"     = var.bucket_harbor_access_key
    "REGISTRY_STORAGE_S3_SECRETKEY" = var.bucket_harbor_secret_key
  }
}

resource "kubernetes_secret_v1" "harbor_core_secret" {
  metadata {
    name      = "harbor-core-secret"
    namespace = "harbor"
  }

  type = "Opaque"

  data = {
    "secretKey" = var.harbor_core_secret
  }
}

resource "kubernetes_secret_v1" "harbor_database_secret" {
  metadata {
    name      = "harbor-database-secret"
    namespace = "harbor"
  }

  type = "Opaque"

  data = {
    "password" = var.harbor_postgres_password
  }
}
