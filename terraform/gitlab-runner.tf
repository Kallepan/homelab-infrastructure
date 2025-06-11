resource "kubernetes_secret" "homelab_ca_gitlab_runner" {
  metadata {
    name      = "homelab-ca"
    namespace = "gitlab-runners"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
    "gitlab.infra.home.arpa.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}

resource "kubernetes_secret" "gitlab_s3_access" {
  metadata {
    name      = "gitlab-runner-s3-access"
    namespace = "gitlab-runners"
  }

  data = {
    "accesskey" = var.bucket_gitlab_runner_access_key
    "secretkey" = var.bucket_gitlab_runner_secret_key
  }

  type = "Opaque"
}

### Gitlab Runner ###
resource "kubernetes_secret" "gitlab_runner_token_secret" {
  metadata {
    name      = "gitlab-runner-token-secret"
    namespace = "gitlab-runners"
  }

  data = {
    "runner-registration-token" = ""
    "runner-token"              = var.gitlab_runner_token
  }

  type = "Opaque"
}