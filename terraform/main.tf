# Network - VPC 

module "vpc_network" {
  source = "./modules/Network"
  vpc_name = var.vpc_name
  subnets_name = var.subnets_name
}

# EKS Cluster
module "eks" {
  source = "./modules/EKS"
  eks_cluster_name = var.cluster_name
  subnets = module.vpc_network.subnets_ids
  node_group = var.node_group

  depends_on = [ module.vpc_network ]
}

# TLS Role
module "tls_role" {
  source = "./modules/tls-role"
  cert_manager_solver_role_name = var.cert_manager_solver_role_name
  node_group_role_arn = module.eks.node_group_role_arn
  hosted_zone_id = var.hosted_zone_id

  depends_on = [ module.eks ]
}

# ArgoCD
module "argocd" {
  source = "./modules/argocd"
  argocd_helm_chart = var.argocd_helm_chart
  depends_on = [ module.eks ]
}
