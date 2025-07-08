data "kubernetes_namespace_v1" "atlas_operator" {
    metadata {
        name = "atlas-operator"
    }
}

resource "kubernetes_secret_v1" "postgres_credentials" {
    metadata {
        name      = "postgres-credentials"
        namespace = data.kubernetes_namespace_v1.atlas_operator.metadata[0].name
    }

    data = {
        "url" = "postgres://${var.postgres_username}:${var.postgres_password}@${var.postgres_host}:${var.postgres_port}/?sslmode=disable" 
    }

    type = "Opaque"
}
