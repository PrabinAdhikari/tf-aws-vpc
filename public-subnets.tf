resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  vpc_id                  = aws_vpc.custom-vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name                     = "${var.private_subnet_name_prefix}-${count.index}"
    "Kubernetes.io/role/elb" = 1
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_vpn_gateway" "vpn" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = {
    Name = "custom_vpn-gateway"
  }
}
resource "aws_vpn_gateway_attachment" "vpc-gateway-attachment" {
  depends_on = [aws_internet_gateway.ig]
  vpc_id         = aws_vpc.custom-vpc.id
  vpn_gateway_id = aws_vpn_gateway.vpn.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = {
    Name = "${var.public_subnet_name_prefix}-route-table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

