locals {
  alb_name    = "zenn-alb"
  alb_tg_name = "zenn-alb-tg"
}

resource "aws_lb" "zenn_alb" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.zenn_alb_sg.id]
  subnets            = [aws_subnet.zenn_public_subnet_1a.id, aws_subnet.zenn_public_subnet_1c.id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "zenn_alb_listener" {
  load_balancer_arn = aws_lb.zenn_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.zenn_alb_tg.arn
  }
}

resource "aws_lb_target_group" "zenn_alb_tg" {
  name        = local.alb_tg_name
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.zenn_vpc.id
  target_type = "ip"

  health_check {
    protocol            = "HTTP"
    path                = "/health"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

# output "alb_dns_name" {
#   value = aws_lb.zenn_alb.dns_name
# }