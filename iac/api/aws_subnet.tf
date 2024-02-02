locals {
  az_1a = "ap-northeast-1a"
  az_1c = "ap-northeast-1c"
}

resource "aws_subnet" "zenn_public_subnet_1a" {
  vpc_id                  = aws_vpc.zenn_vpc.id
  availability_zone       = local.az_1a
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "zenn-public-subnet-1a"
  }
}

resource "aws_subnet" "zenn_public_subnet_1c" {
  vpc_id                  = aws_vpc.zenn_vpc.id
  availability_zone       = local.az_1c
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "zenn-public-subnet-1c"
  }
}

resource "aws_subnet" "zenn_private_subnet_1a" {
  vpc_id                  = aws_vpc.zenn_vpc.id
  availability_zone       = local.az_1a
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "zenn-private-subnet-1a"
  }
}

resource "aws_subnet" "zenn_private_subnet_1c" {
  vpc_id                  = aws_vpc.zenn_vpc.id
  availability_zone       = local.az_1c
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "zenn-private-subnet-1c"
  }
}