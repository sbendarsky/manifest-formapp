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
