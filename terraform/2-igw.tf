resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.formapp-vpc.id

  tags = {
    Name = "igw"
  }
}
