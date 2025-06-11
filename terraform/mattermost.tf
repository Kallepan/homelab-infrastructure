resource "kubernetes_secret_v1" "mattermost_postgres_s3_credentials" {
  metadata {
    name      = "mattermost-postgres-s3-credentials"
    namespace = "mattermost"
  }

  type = "Opaque"

  data = {
    "ACCESS_KEY_ID"     = var.bucket_backups_access_key
    "ACCESS_SECRET_KEY" = var.bucket_backups_secret_key
  }
}

resource "kubernetes_secret_v1" "mattermost_homelab_ca" {
  metadata {
    name      = "homelab-ca"
    namespace = "mattermost"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "name" {
  metadata {
    name      = "mattermost-database-secret"
    namespace = "mattermost"
  }

    data = {
      "DB_CONNECTION_STRING" = var.mattermost_database_connection_string
    }

  type = "Opaque"
}