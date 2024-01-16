# ArgoCD
resource "helm_release" "argocd" {
  name  = var.argocd_helm_chart.release_name

  repository       = var.argocd_helm_chart.repository
  chart            = var.argocd_helm_chart.chart
  namespace        = var.argocd_helm_chart.namespace
  version          = var.argocd_helm_chart.version
  create_namespace = var.argocd_helm_chart.create_namespace
}