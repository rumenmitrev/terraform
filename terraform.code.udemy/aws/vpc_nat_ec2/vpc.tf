resource "aws_vpc" "rm-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "rm-vpc"
  }
}

resource "aws_subnet" "rm-public-1" {
  vpc_id                  = aws_vpc.rm-vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "rm-public-1"
  }
}

resource "aws_subnet" "rm-public-2" {
  vpc_id                  = aws_vpc.rm-vpc.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "rm-public-2"
  }
}

resource "aws_subnet" "rm-public-3" {
  vpc_id                  = aws_vpc.rm-vpc.id
  cidr_block              = "10.10.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "rm-public-3"
  }
}

resource "aws_subnet" "rm-private-1" {
  vpc_id                  = aws_vpc.rm-vpc.id
  cidr_block              = "10.10.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "rm-private-1"
  }
}

resource "aws_subnet" "rm-private-2" {
  vpc_id                  = aws_vpc.rm-vpc.id
  cidr_block              = "10.10.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  tags = {
    Name = "rm-private-2"
  }
}

resource "aws_subnet" "rm-private-3" {
  vpc_id                  = aws_vpc.rm-vpc.id
  cidr_block              = "10.10.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"
  tags = {
    Name = "rm-private-3"
  }
}

resource "aws_internet_gateway" "rm-igw" {
  vpc_id = aws_vpc.rm-vpc.id
  tags = {
    Name = "rm-igw"
  }
}

resource "aws_route_table" "rm-rt-public" {
  vpc_id = aws_vpc.rm-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rm-igw.id
  }
  tags = {
    Name = "rm-rt-public-1"
  }
}

resource "aws_route_table_association" "rt-accoss-public-1a" {
  route_table_id = aws_route_table.rm-rt-public.id
  subnet_id      = aws_subnet.rm-public-1.id
}

resource "aws_route_table_association" "rt-accoss-public-1b" {
  route_table_id = aws_route_table.rm-rt-public.id
  subnet_id      = aws_subnet.rm-public-2.id
}

resource "aws_route_table_association" "rt-accoss-public-1c" {
  route_table_id = aws_route_table.rm-rt-public.id
  subnet_id      = aws_subnet.rm-public-3.id
}