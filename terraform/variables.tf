# provider.tf Variables
variable "region" {
  description = "value of the region"
  type        = string
}

# vpc_network Variables
variable "vpc_name" {
  description = "VPC name to create"
  type = string
}

variable "subnets_name" {
  type        = list(string)
  description = "list of subnets names to create"
}

# EKS Variables
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_group" {
  type = object({
    name = string
    instance_types = list(string)
    desired_size = number
    max_size     = number
    min_size     = number
    max_unavailable = number
  })
  description = "node group configuration"
}

# TLS Role Variables
variable "cert_manager_solver_role_name" {
  type = string
  description = "Name of the Role that will allow cert manager to resolve the tls challenge"
}

variable "node_group_role_arn" {
  type = string
  description = "node group role arn"
}

variable "hosted_zone_id" {
  type = string
  description = "id of the hosted zone"
}

# ArgoCD
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
