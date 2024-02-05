provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.cluster.id]
      command     = "aws"
    }
  }
}

resource "helm_release" "aws-load-balancer-controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.4.1"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.cluster.id
  }

  set {
    name  = "image.tag"
    value = "v2.4.2"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }

  depends_on = [
    aws_eks_node_group.private-nodes,
    aws_iam_role_policy_attachment.aws_load_balancer_controller_attach
  ]
}

#aws-ebs-csi-driver
resource "helm_release" "ebs-csi-driver" {
  name = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  namespace = "kube-system"
  chart = "aws-ebs-csi-driver"
}

# Create ArgoCD
resource "helm_release" "argocd" {
  name  = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.20.3"
  create_namespace = true

  depends_on = [
    aws_eks_node_group.private-nodes,
    helm_release.aws-load-balancer-controller,
    helm_release.ebs-csi-driver
  ]
}

# deploy argocd application
resource "helm_release" "argocd-apps" {
  name       = "argocd-apps"
  
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  namespace  = "argocd"
  version    = "0.0.8"

  values = [
    file("applications/apps-of-apps.yaml")
  ]

  depends_on = [
    helm_release.argocd
  ]
}