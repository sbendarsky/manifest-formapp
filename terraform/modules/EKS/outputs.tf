output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "node_group_id" {
  value = aws_eks_node_group.node_group.id
}

output "node_group_arn" {
  value = aws_iam_role.node_group_role.arn
}