variable "argocd_helm_chart" {
  type = object({
    release_name = string
    repository = string
    chart = string
    namespace = string
    version = string
    create_namespace = bool
  })
  description = "ArgoCD helm chart configuration"
}