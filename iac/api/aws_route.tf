resource "aws_route_table" "zenn_public_route_table" {
  vpc_id = aws_vpc.zenn_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zenn_igw.id
  }

  tags = {
    Name = "zenn-public-route-table"
  }
}

resource "aws_route_table_association" "zenn_public_1a_route_table_association" {
  subnet_id      = aws_subnet.zenn_public_subnet_1a.id
  route_table_id = aws_route_table.zenn_public_route_table.id
}

resource "aws_route_table_association" "zenn_public_1c_route_table_association" {
  subnet_id      = aws_subnet.zenn_public_subnet_1c.id
  route_table_id = aws_route_table.zenn_public_route_table.id
}

resource "aws_route_table" "zenn_private_route_table" {
  vpc_id = aws_vpc.zenn_vpc.id

  tags = {
    Name = "zenn-private-route-table"
  }
}

resource "aws_route_table_association" "zenn_private_1a_route_table_association" {
  subnet_id      = aws_subnet.zenn_private_subnet_1a.id
  route_table_id = aws_route_table.zenn_private_route_table.id
}

resource "aws_route_table_association" "zenn_private_1c_route_table_association" {
  subnet_id      = aws_subnet.zenn_private_subnet_1c.id
  route_table_id = aws_route_table.zenn_private_route_table.id
}