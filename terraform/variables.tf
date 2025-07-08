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

variable "argo_workflows_postgres_username" {
  description = "Username for the Argo Workflows PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "argo_workflows_postgres_password" {
  description = "Password for the Argo Workflows PostgreSQL database"
  type        = string
  sensitive   = true
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

### Minio Configuration Variables ###
variable "minio_user" {
  description = "The user for Minio"
  type        = string
  sensitive   = true
}

variable "minio_password" {
  description = "The password for Minio"
  type        = string
  sensitive   = true
}

variable "bucket_argo_secret_key" {
  description = "Secret key for the Argo bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_backups_secret_key" {
  description = "Secret key for the Backups bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_secret_key" {
  description = "Secret key for the GitLab bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_runner_secret_key" {
  description = "Secret key for the GitLab Runner bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_loki_secret_key" {
  description = "Secret key for the Loki bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_rancher_secret_key" {
  description = "Secret key for the Rancher bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_argo_access_key" {
  description = "Access key for the Argo bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_backups_access_key" {
  description = "Access key for the Backups bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_access_key" {
  description = "Access key for the GitLab bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_gitlab_runner_access_key" {
  description = "Access key for the GitLab Runner bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_loki_access_key" {
  description = "Access key for the Loki bucket in Minio"
  type        = string
  sensitive   = true
}

variable "bucket_rancher_access_key" {
  description = "Access key for the Rancher bucket in Minio"
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

## Argo Configuration Variables
variable "argo_oauth_client_id" {
  description = "OAuth client ID for argo"
  type        = string
  sensitive   = true
}
variable "argo_oauth_client_secret" {
  description = "OAuth client secret for argo"
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

## Mattermost Configuration Variables
variable "mattermost_database_connection_string" {
  description = "Connection string for the Mattermost database"
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
