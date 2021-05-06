resource "aws_vpc" "custom_vpc_1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnet0" {
  cidr_block = var.private_subnet0_cidr
  vpc_id = aws_vpc.custom_vpc_1.id
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet0"
  }
}

resource "aws_subnet" "private_subnet1" {
  cidr_block = var.private_subnet1_cidr
  vpc_id = aws_vpc.custom_vpc_1.id
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "public_subnet0" {
  cidr_block = var.public_subnet0_cidr
  vpc_id = aws_vpc.custom_vpc_1.id
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet0"
  }
}

resource "aws_subnet" "public_subnet1" {
  cidr_block = var.public_subnet1_cidr
  vpc_id = aws_vpc.custom_vpc_1.id
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet1"
  }
}