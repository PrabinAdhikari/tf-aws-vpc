resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  vpc_id                  = aws_vpc.custom-vpc.id
  map_public_ip_on_launch = false
  tags = {
    Name                              = "${var.private_subnet_name_prefix}-${count.index}"
    "Kubernetes.io/role/internal-elb" = 1
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = {
    Name = "${var.private_subnet_name_prefix}-route-table"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "end_point_sg" {
  description = "security group to govern who can access the endpoints"
  vpc_id      = aws_vpc.custom-vpc.id
  ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
  }
}