resource "kubernetes_secret_v1" "keycloak_postgres_credentials" {
  metadata {
    name      = "keycloak-postgres-credentials"
    namespace = "keycloak"
  }

  type = "Opaque"

  data = {
    "postgres_username"     = var.keycloak_postgres_username
    "postgres_password" = var.keycloak_postgres_password
  }
}