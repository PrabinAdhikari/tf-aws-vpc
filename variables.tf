variable "vpc_name" {
  default = "custom_vpc1"
}

variable "region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/22"
}
variable "private_subnet0_cidr" {
  default = "10.0.0.0/24"
}
variable "private_subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet0_cidr" {
  default = "10.0.2.0/24"
}

variable "public_subnet1_cidr" {
  default = "10.0.3.0/24"
}