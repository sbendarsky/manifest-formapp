resource "aws_vpc" "_Test_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Test_VPC"
  }
}

resource "aws_subnet" "publicSubnet1" {
  vpc_id = aws_vpc._Test_VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "_sb-Public1"
  }
}

resource "aws_subnet" "publicSubnet2" {
  vpc_id = aws_vpc._Test_VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "_sb-Public2"
  }
}

resource "aws_subnet" "privateSubnet1" {
  vpc_id = aws_vpc._Test_VPC.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "_sb-Private1"
  }
}

resource "aws_subnet" "privateSubnet2" {
  vpc_id = aws_vpc._Test_VPC.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "_sb-Private2"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc._Test_VPC.id

  tags = {
    Name = "_IGW"
  }
}

resource "aws_route_table" "_RT1" {
  vpc_id = aws_vpc._Test_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
        Name = "_RT1"
    }
}

resource "aws_route_table" "_RT2" {
  vpc_id = aws_vpc._Test_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
        Name = "_RT2"
    }
}

resource "aws_route_table" "_RT3" {
  vpc_id = aws_vpc._Test_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
        Name = "_RT3"
    }
}

resource "aws_route_table" "_RT4" {
  vpc_id = aws_vpc._Test_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
        Name = "_RT4"
    }
}

resource "aws_route_table_association" "_Association1" {
  subnet_id = aws_subnet.publicSubnet1.id
  route_table_id = aws_route_table._RT1.id
}

resource "aws_route_table_association" "_Association2" {
  subnet_id = aws_subnet.publicSubnet2.id
  route_table_id = aws_route_table._RT2.id
}

resource "aws_route_table_association" "_Association3" {
  subnet_id = aws_subnet.privateSubnet1.id
  route_table_id = aws_route_table._RT3.id
}

resource "aws_route_table_association" "_Association4" {
  subnet_id = aws_subnet.privateSubnet2.id
  route_table_id = aws_route_table._RT4.id
}

