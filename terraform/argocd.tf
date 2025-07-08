resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [kubernetes_namespace_v1.argocd]

  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace = kubernetes_namespace_v1.argocd.metadata[0].name

  wait = true

  values = [
    templatefile("${path.module}/values/argocd-values.yaml", {
      root_ca = file(var.cert_manager_ca_crt_path)
    })
  ]
}

resource "kubectl_manifest" "argocd_app_of_apps" {
  depends_on = [helm_release.argocd, kubernetes_namespace_v1.argocd]

  yaml_body = templatefile("${path.module}/manifests/argocd-app-of-apps.yaml", {
    namespace       = kubernetes_namespace_v1.argocd.metadata[0].name
    repo_url        = var.argocd_repo_url
    target_revision = var.argocd_target_revision
    path            = var.argocd_app_of_apps_path
  })
}