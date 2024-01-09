resource "aws_eks_cluster" "eks-formapp" {
  name     = "eks-formapp"
  version  = "1.28"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.Private1.id,
      aws_subnet.Private2.id,
      aws_subnet.Public1.id,
      aws_subnet.Public2.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.formapp_amazon_eks_cluster_policy]
}

data "aws_eks_cluster_auth" "eks-formapp" {
 name = "eks-formapp"
}