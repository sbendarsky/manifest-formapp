variable "vpc_name" {
  default = "project_vpc"
}

variable "vpcCider" {
  default = "172.20.0.0/16"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "az3" {
  default = "us-east-1c"
}

variable "publicSubnet1" {
    default = "172.20.1.0/24"
}

variable "publicSubnet2" {
    default = "172.20.2.0/24"
}

variable "publicSubnet3" {
    default = "172.20.3.0/24"
}

variable "privateSubnet1" {
    default = "172.20.4.0/24"
}

variable "privateSubnet2" {
    default = "172.20.5.0/24"
}

variable "privateSubnet3" {
    default = "172.20.6.0/24"
}


