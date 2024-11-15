resource "aws_eip" "rm-nat" {
  #   vpc = true
}

resource "aws_nat_gateway" "rm-nat-gw" {
  allocation_id = aws_eip.rm-nat.id
  subnet_id     = aws_subnet.rm-public-1.id
  depends_on    = [aws_internet_gateway.rm-igw]
}

resource "aws_route_table" "rm-private-rt" {
  vpc_id = aws_vpc.rm-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.rm-nat-gw.id
  }
  tags = {
    Name = "rm-private-nat-gw"
  }
}

resource "aws_route_table_association" "rm-private-1a" {
  subnet_id      = aws_subnet.rm-private-1.id
  route_table_id = aws_route_table.rm-private-rt.id
}

resource "aws_route_table_association" "rm-private-1b" {
  subnet_id      = aws_subnet.rm-private-2.id
  route_table_id = aws_route_table.rm-private-rt.id
}

resource "aws_route_table_association" "rm-private-1c" {
  subnet_id      = aws_subnet.rm-private-3.id
  route_table_id = aws_route_table.rm-private-rt.id
}