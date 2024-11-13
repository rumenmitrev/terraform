# --- networking/main.tf ---

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "rm_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "rm_vpc-${random_integer.random.id}"
  }
}

resource "aws_subnet" "rm_public_subnet" {
  count                   = length(var.public_cidirs)
  vpc_id                  = aws_vpc.rm_vpc.id
  cidr_block              = var.public_cidirs[count.index]
  map_public_ip_on_launch = true
  availability_zone = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d"
  ][count.index]
  tags = {
    Name = "rm_publc_${count.index + 1}"
  }
}