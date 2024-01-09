provider "kubectl" {
    host = aws_eks_cluster.eks-formapp.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-formapp.certificate_authority.0.data)
    token = data.aws_eks_cluster_auth.eks-formapp.token
    load_config_file = false
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks-formapp.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-formapp.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.eks-formapp.token
  }
}

provider "kubernetes" {
    host = aws_eks_cluster.eks-formapp.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-formapp.certificate_authority.0.data)
    token = data.aws_eks_cluster_auth.eks-formapp.token
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
    depends_on = [ aws_eks_cluster.eks-formapp ]
}

resource "helm_release" "argocd" {
 name      = "argocd"
 namespace = "argocd"
 repository = "https://argoproj.github.io/argo-helm"
 chart     = "argo-cd"
 version = "5.19.12"
 values = [
    "${file("${path.module}/helm/argocd-values.yaml")}"
 ]
 depends_on = [ kubernetes_namespace.argocd ]
}