resource "aws_vpc" "FormApp_VPC" {
  cidr_block = var.vpc_cidr

    tags = {
        Name = "FormApp_VPC"
    }
}

resource "aws_subnet" "Public1" {
  vpc_id = aws_vpc.FormApp_VPC.id
  cidr_block = var.subnetcidr1
  availability_zone = var.azpublic1
  tags = {
    Name = "sb-public1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "Public2" {
  vpc_id = aws_vpc.FormApp_VPC.id
  cidr_block = var.subnetcidr2
  availability_zone = var.azpublic2
  tags = {
    Name = "sb-public2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "Private1" {
  vpc_id = aws_vpc.FormApp_VPC.id
  cidr_block = var.subnetcidr3
  availability_zone = var.azpublic1
  tags = {
    Name = "sb-private1"
        "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "Private2" {
  vpc_id = aws_vpc.FormApp_VPC.id
  cidr_block = var.subnetcidr4
  availability_zone = var.azpublic2
  tags = {
    Name = "sb-private2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.FormApp_VPC.id
    tags = {
        Name = "IGW"
    }
}

resource "aws_eip" "nat" {
   depends_on = [aws_internet_gateway.IGW]
}

resource "aws_eip" "nat2" {
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.Public2.id
  tags = {
    Name = "nat2"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Public1.id
  tags = {
    Name = "nat"
  }
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.FormApp_VPC.id
    route {
        cidr_block = var.quadzero
        gateway_id = aws_internet_gateway.IGW.id
}
    tags = {
        Name = "PublicRT1"
    }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.FormApp_VPC.id
    route {
        cidr_block = var.quadzero
        gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "PrivateRT1"
    }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.Public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.Public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.Private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.Private2.id
  route_table_id = aws_route_table.private.id
}