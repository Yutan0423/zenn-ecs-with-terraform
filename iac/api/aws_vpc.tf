resource "aws_vpc" "zenn_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "zenn-vpc"
  }
}

resource "aws_internet_gateway" "zenn_igw" {
  vpc_id = aws_vpc.zenn_vpc.id

  tags = {
    Name = "zenn-igw"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.zenn_vpc.id
  service_name      = "com.amazonaws.${local.region}.ecr.api"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.zenn_private_subnet_1a.id, aws_subnet.zenn_private_subnet_1c.id]

  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ecr_vpc_endpoint_sg.id]

  tags = {
    Name = "zenn-vpce-ecr-api"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.zenn_vpc.id
  service_name      = "com.amazonaws.${local.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.zenn_private_subnet_1a.id, aws_subnet.zenn_private_subnet_1c.id]

  private_dns_enabled = true
  security_group_ids  = [aws_security_group.ecr_vpc_endpoint_sg.id]

  tags = {
    Name = "zenn-vpce-ecr-dkr"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.zenn_vpc.id
  service_name      = "com.amazonaws.${local.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [aws_route_table.zenn_private_route_table.id]

  tags = {
    Name = "zenn-vpce-s3"
  }
}