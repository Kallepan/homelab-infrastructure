variable "kubernetes_config_path" {
  description = "Path to the kubeconfig file for kubectl provider"
  type        = string
  default     = "~/.kube/config"
}

### Atlas Operator Configuration Variables ###
variable "postgres_username" {
  description = "Username for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "Password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "postgres_host" {
  description = "Host for the PostgreSQL database"
  type        = string
  default     = "psql.storage.home.arpa"
}

variable "postgres_port" {
  description = "Port for the PostgreSQL database"
  type        = number
  default     = 5432
}

### ArgoCD Configuration Variables ###
variable "argocd_repo_url" {
  description = "URL of the Git repository for ArgoCD applications"
  type        = string
  default     = "https://github.com/Kallepan/homelab-kubernetes.git"
}

variable "argocd_target_revision" {
  description = "Target revision for the ArgoCD applications"
  type        = string
  default     = "main"
}

variable "argocd_app_of_apps_path" {
  description = "Path to the ArgoCD App of Apps manifest in the repository"
  type        = string
  default     = "app-of-apps/deploy/overlays/infrastructure"
}

### Cert-Manager Configuration Variables ##
variable "cert_manager_ca_crt_path" {
  description = "Path to the CA certificate for Cert-Manager"
  type        = string
}

variable "cert_manager_ca_key_path" {
  description = "Path to the CA key for Cert-Manager"
  type        = string
}

variable "bucket_gitlab_secret_key" {
  description = "Secret key for the GitLab bucket"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_runner_secret_key" {
  description = "Secret key for the GitLab Runner bucket"
  type        = string
  sensitive   = true
}

variable "bucket_loki_secret_key" {
  description = "Secret key for the Loki bucket"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_access_key" {
  description = "Access key for the GitLab bucket"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_runner_access_key" {
  description = "Access key for the GitLab Runner bucket"
  type        = string
  sensitive   = true
}

variable "bucket_loki_access_key" {
  description = "Access key for the Loki bucket"
  type        = string
  sensitive   = true
}

### Alertmanager Configuration Variables
variable "alertmanager_mattermost_webhook_url" {
  description = "Webhook URL for Alertmanager metrics notifications to Mattermost"
  type        = string
  sensitive   = true
}

## Grafana Configuration Variables
variable "grafana_oauth_client_id" {
  description = "OAuth client ID for Grafana"
  type        = string
  sensitive   = true
}
variable "grafana_oauth_client_secret" {
  description = "OAuth client secret for Grafana"
  type        = string
  sensitive   = true
}

## GitLab Configuration Variables
variable "gitlab_oauth_client_id" {
  description = "OAuth client ID for GitLab"
  type        = string
  sensitive   = true
}
variable "gitlab_oauth_client_secret" {
  description = "OAuth client secret for GitLab"
  type        = string
  sensitive   = true
}

variable "gitlab_postgres_username" {
  description = "Username for the GitLab PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "gitlab_postgres_password" {
  description = "Password for the GitLab PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "gitlab_registry_postgres_username" {
  description = "Username for the GitLab Container Registry"
  type        = string
  sensitive   = true
}

variable "gitlab_registry_postgres_password" {
  description = "Password for the GitLab Container Registry"
  type        = string
  sensitive   = true
}

## GitLab Runner Configuration Variables
variable "gitlab_runner_token" {
  description = "GitLab Runner registration token"
  type        = string
  sensitive   = true
}

## Keycloak Configuration Variables
variable "keycloak_postgres_username" {
  description = "Username for the Keycloak PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "keycloak_postgres_password" {
  description = "Password for the Keycloak PostgreSQL database"
  type        = string
  sensitive   = true
}

## Harbor Configuration Variables
variable "bucket_harbor_access_key" {
  description = "Access key for the Harbor bucket"
  type        = string
  sensitive   = true
}

variable "bucket_harbor_secret_key" {
  description = "Secret key for the Harbor bucket"
  type        = string
  sensitive   = true
}

variable "harbor_core_secret" {
  description = "Core secret for Harbor"
  type        = string
  sensitive   = true
}

variable "harbor_postgres_password" {
  description = "Password for the Harbor database"
  type        = string
  sensitive   = true
}
