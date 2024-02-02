locals {
  cluster_name  = "zenn-cluster" # ECS cluster name
  service_name  = "zenn-service" # ECS service name
  region        = "ap-northeast-1" # AWS region
  ecr_name      = "zenn-ecs-with-terraform-api" # ECR repository name
  ecr_image     = "${var.aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/zenn-ecs-with-terraform-api:latest" # ECR image URI
  ecr_task_role = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole" # ECS task role ARN
  ecs_task_cpu = 256 # ECS task CPU
  ecs_task_memory = 512 # ECS task memory
  ecs_service_desired_count = 2 # ECS service desired count
}

resource "aws_ecs_cluster" "zenn_cluster" {
  name = local.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "zenn_cluster_capacity_providers" {
  cluster_name       = aws_ecs_cluster.zenn_cluster.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "zenn_cluster_task" {
  family                   = "zenn_cluster_task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = local.ecs_task_cpu
  memory                   = local.ecs_task_memory
  network_mode             = "awsvpc"
  execution_role_arn       = local.ecr_task_role
  task_role_arn            = local.ecr_task_role
  container_definitions = jsonencode([
    {
      name      = local.ecr_name
      image     = local.ecr_image
      cpu       = local.ecs_task_cpu
      memory    = local.ecs_task_memory
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "zenn_service" {
  name            = local.service_name
  cluster         = local.cluster_name
  task_definition = aws_ecs_task_definition.zenn_cluster_task.arn
  desired_count   = local.ecs_service_desired_count
  

  load_balancer {
    target_group_arn = aws_lb_target_group.zenn_alb_tg.arn
    container_name   = local.ecr_name
    container_port   = 8080
  }

  network_configuration {
    subnets         = [aws_subnet.zenn_private_subnet_1a.id, aws_subnet.zenn_private_subnet_1c.id]
    security_groups = [aws_security_group.zenn_ecs_sg.id]
  }
}
