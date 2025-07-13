resource "kubernetes_secret_v1" "gitlab_postgres_credentials" {
  metadata {
    name      = "gitlab-postgres-credentials"
    namespace = "gitlab"
  }

  type = "Opaque"

  data = {
    "postgres_user"     = var.gitlab_postgres_username
    "postgres_password" = var.gitlab_postgres_password
  }
}

resource "kubernetes_secret" "homelab_ca_gitlab" {
  metadata {
    name      = "homelab-ca"
    namespace = "gitlab"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
    "gitlab.infra.home.arpa.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "gitlab_oauth_credentials" {
  metadata {
    name      = "grafana-oauth-credentials"
    namespace = "gitlab"
  }

  data = {
    "client_id"     = var.gitlab_oauth_client_id
    "client_secret" = var.gitlab_oauth_client_secret
  }

  type = "Opaque"
}


resource "kubernetes_secret" "gitlab_keycloak_omniauth" {
  metadata {
    name      = "gitlab-keycloak-omniauth"
    namespace = "gitlab"
  }

  data = {
    "omniauth.yml" = templatefile("files/gitlab-openid-secret.yaml",{
      oauth_client_id = var.gitlab_oauth_client_id
      oauth_client_secret = var.gitlab_oauth_client_secret
    })
  }
  type = "Opaque"
}

resource "kubernetes_secret_v1" "gitlab_registry_postgres_credentials" {
  metadata {
    name      = "gitlab-registry-postgres-credentials"
    namespace = "gitlab"
  }

  type = "Opaque"

  data = {
    "postgres_user"     = var.gitlab_registry_postgres_username
    "postgres_password" = var.gitlab_registry_postgres_password
  }
}

resource "kubernetes_secret" "gitlab_registry_minio_connection" {
  metadata {
    name      = "gitlab-registry-minio-connection"
    namespace = "gitlab"
  }

  data = {
    "registry.s3.yml" = templatefile("files/gitlab-registry.s3.yml", {
      gitlab_registry_s3_access_key = var.bucket_gitlab_access_key
      gitlab_registry_s3_secret_key = var.bucket_gitlab_secret_key
    })
  }
}

resource "kubernetes_secret" "gitlab_minio_connection" {
  metadata {
    name      = "gitlab-minio-connection"
    namespace = "gitlab"
  }

  data = {
    "connection.yml" = templatefile("files/gitlab-minio-connection.yml", {
      gitlab_minio_access_key = var.bucket_gitlab_access_key
      gitlab_minio_secret_key = var.bucket_gitlab_secret_key
    })
  }

  type = "Opaque"
}

resource "kubernetes_secret" "gitlab_backups_minio_creds" {
  metadata {
    name      = "gitlab-backups-minio-creds"
    namespace = "gitlab"
  }

  data = {
    "config" = templatefile("${path.module}/files/gitlab-backup.s3cfg",{
      backup_access_key = var.bucket_gitlab_access_key
      backup_secret_key = var.bucket_gitlab_secret_key
    })
  }

  type = "Opaque"
}
