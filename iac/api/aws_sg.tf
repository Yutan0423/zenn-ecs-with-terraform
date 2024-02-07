locals {
  alb_sg_name = "zenn-alb-sg"
  ecs_sg_name = "zenn-ecs-sg"
  ecr_vpce_sg = "zenn-ecr-vpce-sg"
}

resource "aws_security_group" "zenn_alb_sg" {
  name        = "zenn_alb_sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.zenn_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "zenn_ecs_sg" {
  name        = local.ecs_sg_name
  description = "Security group for ECS"
  vpc_id      = aws_vpc.zenn_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecr_vpc_endpoint_sg" {
  name        = local.ecr_vpce_sg
  description = "Security Group for ECR VPC Endpoints"
  vpc_id      = aws_vpc.zenn_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.zenn_vpc.cidr_block]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.zenn_vpc.cidr_block]
  }
}