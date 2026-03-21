resource "kubernetes_secret_v1" "sonarqube_custom_ca_certs" {
  metadata {
    name      = "sonarqube-custom-ca-certs"
    namespace = "sonarqube"
  }

  data = {
    "homelab-ca.crt" = file(var.cert_manager_ca_crt_path)
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "sonarqube_monitoring_passcode" {
  metadata {
    name      = "sonarqube-monitoring-passcode"
    namespace = "sonarqube"
  }

  data = {
    "passcode" = var.sonarqube_monitoring_passcode
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "sonarqube_postgres_credentials" {
    metadata {
        name      = "sonarqube-postgres-credentials"
        namespace = "sonarqube"
    }
    
    type = "Opaque"
    
    data = {
        "jdbc-password" = var.sonarqube_postgres_password
    }
}