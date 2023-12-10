
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone      = var.variables_sub_az
  map_public_ip_on_launch = var.public_sub_auto_ip
  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
   availability_zone      = var.variables_sub_az
  map_public_ip_on_launch = var.private_sub_auto_ip
  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  associate_subnet = [aws_subnet.public_subnet.id]
}

resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  depends_on = [aws_internet_gateway.my_igw]
}

resource "aws_eip" "my_eip" {
  vpc = true
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }

  associate_subnet = [aws_subnet.private_subnet.id]
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}