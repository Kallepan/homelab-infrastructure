resource "kubernetes_secret_v1" "cert_manager_ca" {
  metadata {
    name      = "cert-manager-ca"
    namespace = "cert-manager"
  }

  data = {
    "tls.crt" = file(var.cert_manager_ca_crt_path)
    "tls.key" = file(var.cert_manager_ca_key_path)
  }

  type = "kubernetes.io/tls"
}