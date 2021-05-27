variable "common_prefix_name" {
  default = "example"
}
variable "vpc_name" {
  default = "custom-vpc"
}

variable "region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/22"
}
variable "private_subnets_cidr" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.3.0/24"]
}

variable "public_subnets_cidr" {
  default = ["10.0.2.0/24"]
}
variable "private_subnet_name_prefix" {
  default = "private-subnet"
}

variable "public_subnet_name_prefix" {
  default = "public-subnet"
}
variable "internet_gateway_name" {
  default     = "internet-gateway"
  description = "Internet gateway for public subnets"
}

variable "nat_gateway_name" {
  default = "nat-gateway"
}