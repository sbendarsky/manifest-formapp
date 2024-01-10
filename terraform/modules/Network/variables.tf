# VPC.tf Variables
variable "vpc_cidr_block" {
  type = string
  description = "value of the VPC CIDR block"
  default = "10.0.0.0/16"
}


variable "vpc_name" {
  type = string
  description = "value of the VPC name"
}

# Subnets.tf Variables
variable "subnets_name" {
  description = "Name of subnets"
  type = list(string)
}

variable "subnet_cidr_block" {
  description = "CIDR block of subnets"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}