
locals {
  service_names = [
    "ecr.api",
    "ecr.dkr",
    "ec2",
    "logs",
    "sts"
  ]
}
resource "aws_vpc_endpoint" "s3_api_end_point" {
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]
  vpc_id            = aws_vpc.custom-vpc.id
  tags = {
    Name = "${var.common_prefix_name}-s3_api_end_point"
  }
}

resource "aws_vpc_endpoint" "ecr_api_end_point" {
  count               = length(local.service_names)
  service_name        = "com.amazonaws.${var.region}.${element(local.service_names, count.index)}"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.eks_end_point_sg.id]
  subnet_ids          = [element(aws_subnet.private_subnet.*.id, count.index)]
  vpc_id              = aws_vpc.custom-vpc.id
  tags = {
    Name = "${var.common_prefix_name}-${element(local.service_names, count.index)}"
  }
}