region = "us-east-1"

# VPC Module Vars
vpc_name = "formapp-vpc"
subnets_name = [ "formapp-1a", "formapp-1b" ]

# EKS Module Vars
cluster_name = "formapp-cluster"

node_group = {
  name = "formapp-node-group"
  instance_types = [ "t3.medium" ]
  desired_size = 1
  max_size = 1
  min_size = 1
  max_unavailable = 1
}

# ArgoCD Module Vars
argocd_helm_chart = {
    release_name = "argocd"
    repository = "https://argoproj.github.io/argo-helm"
    chart = "argo-cd"
    namespace = "argocd"
    version = "5.20.3"
    create_namespace = true
}