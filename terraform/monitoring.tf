resource "kubernetes_secret_v1" "loki_secrets" {
  metadata {
    name      = "loki-secrets"
    namespace = "observability"
  }

  type = "Opaque"

  data = {
    "LOKI_S3_ACCESS_KEY_ID"     = var.bucket_loki_access_key
    "LOKI_S3_SECRET_ACCESS_KEY" = var.bucket_loki_secret_key
  }
}

resource "kubernetes_secret_v1" "homelab_ca_monitoring" {
  metadata {
    name      = "homelab-ca"
    namespace = "observability"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}

resource "kubernetes_secret" "alertmanager_mattermost_webhook_url" {
  metadata {
    name      = "alertmanager-mattermost-webhook-url"
    namespace = "observability"
  }

  data = {
    "mattermost-webhook-url" = var.alertmanager_mattermost_webhook_url
  }

  type = "Opaque"
}
resource "kubernetes_secret_v1" "grafana_oauth_credentials" {
  metadata {
    name      = "grafana-oauth-credentials"
    namespace = "observability"
  }

  data = {
    "client_id"     = var.grafana_oauth_client_id
    "client_secret" = var.grafana_oauth_client_secret
  }

  type = "Opaque"
}