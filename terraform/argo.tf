resource "kubernetes_secret_v1" "argo_workflows_postgres_credentials" {
  metadata {
    name      = "argo-workflows-postgres-credentials"
    namespace = "argo"
  }

  type = "Opaque"

  data = {
    "postgres_username"     = var.argo_workflows_postgres_username
    "postgres_password" = var.argo_workflows_postgres_password
  }
}

resource "kubernetes_secret_v1" "argo_workflows_s3_credentials" {
  metadata {
    name      = "argo-workflows-s3-credentials"
    namespace = "argo"
  }

    type = "Opaque"
    
    data = {
        "accessKey" = var.bucket_argo_access_key
        "secretKey" = var.bucket_argo_secret_key
    }
}


resource "kubernetes_secret_v1" "argo_homelab_ca" {
  metadata {
    name      = "homelab-ca"
    namespace = "argo"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "argo_server_sso" {
  metadata {
    name      = "argo-server-sso"
    namespace = "argo"
  }

  type = "Opaque"

  data = {
    "client-id"     = var.argo_oauth_client_id
    "client-secret" = var.argo_oauth_client_secret
  }
}