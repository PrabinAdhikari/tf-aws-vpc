resource "aws_vpc" "custom-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_security_group" "eks_control_panel_sg" {
  vpc_id      = aws_vpc.custom-vpc.id
  description = "cluster communication with worker nodes"
}