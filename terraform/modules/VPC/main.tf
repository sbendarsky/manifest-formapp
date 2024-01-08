module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpcCider

  azs             = [var.az1, var.az2, var.az3]
  private_subnets = [var.privateSubnet1, var.privateSubnet2, var.privateSubnet3]
  public_subnets  = [var.publicSubnet1, var.publicSubnet2, var.publicSubnet3]
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}