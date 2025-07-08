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