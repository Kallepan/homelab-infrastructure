resource "kubernetes_secret_v1" "keycloak_postgres_s3_credentials" {
  metadata {
    name      = "keycloak-postgres-s3-credentials"
    namespace = "keycloak"
  }

  type = "Opaque"

  data = {
    "ACCESS_KEY_ID"     = var.bucket_backups_access_key
    "ACCESS_SECRET_KEY" = var.bucket_backups_secret_key
  }
}

resource "kubernetes_secret_v1" "keycloak_homelab_ca" {
  metadata {
    name      = "homelab-ca"
    namespace = "keycloak"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}