variable "aws_region" {
  default = "us-east-1"
}

variable "backend_bucket" {
  default = "formapp-tfstate-bucket"
}

variable "vpc_cidr" {
  default = "172.20.0.0/16"
}

variable "subnetcidr1" {
  default = "172.20.1.0/24"
}

variable "azpublic1" {
  default = "us-east-1a"
}

variable "subnetcidr2" {
  default = "172.20.2.0/24"
}

variable "azpublic2" {
  default = "us-east-1b"
}

variable "subnetcidr3" {
  default = "172.20.3.0/24"
}

variable "subnetcidr4" {
  default = "172.20.4.0/24"
}

variable "quadzero" {
  default = "0.0.0.0/0"
}



