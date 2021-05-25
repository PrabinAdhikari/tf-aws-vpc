
locals {
  service_names = [
    "com.amazonaws.${var.region}.ecr.api",
    "com.amazonaws.${var.region}.ecr.dkr",
    "com.amazonaws.${var.region}.ec2",
    "com.amazonaws.${var.region}.logs",
    "com.amazonaws.${var.region}.sts"
  ]
}
resource "aws_vpc_endpoint" "s3_api_end_point" {
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]
  vpc_id            = aws_vpc.custom-vpc.id
  tags = {
    Name = "test"
  }
}

resource "aws_vpc_endpoint" "ecr_api_end_point" {
  count               = length(local.service_names)
  service_name        = element(local.service_names, count.index)
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.end_point_sg.id]
  subnet_ids          = [element(aws_subnet.private_subnet.*.id, count.index)]
  vpc_id              = aws_vpc.custom-vpc.id
}