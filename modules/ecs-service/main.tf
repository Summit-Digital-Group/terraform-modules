module "this_container_def" {
  source                       = "cloudposse/ecs-container-definition/aws"
  version                      = "0.56.0"
  container_name               = var.container_name
  container_image              = var.container_image
  readonly_root_filesystem     = true
  environment                  = var.environment_vars
  secrets                      = var.secrets
  port_mappings                = [{ containerPort : var.container_port, hostPort : local.host_port, protocol : "tcp" }]
  container_cpu                = var.cpu
  container_memory_reservation = var.memory
  log_configuration = {
    "logDriver" = "awslogs",
    "options" : {
      "awslogs-region"        = var.region
      "awslogs-group"         = var.awslogs_group
      "awslogs-stream-prefix" = local.awslogs_prefix
    }
  }
}

resource "aws_ecs_task_definition" "this" {
  execution_role_arn       = aws_iam_role.ecs.arn
  task_role_arn            = aws_iam_role.ecs.arn
  family                   = local.name_prefix
  requires_compatibilities = var.requires_compatibilities
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  tags                     = var.tags
  container_definitions    = <<EOF
[
  ${module.this_container_def.json_map_encoded}
]
EOF

}

resource "aws_ecs_service" "this" {
  lifecycle {
    ignore_changes = [desired_count]
  }
  name                               = local.name_prefix
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.this.arn
  launch_type                        = var.launch_type
  desired_count                      = var.container_count
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  force_new_deployment = var.force_new_deployment
  tags                 = var.tags
  load_balancer {
    container_name   = var.container_name
    container_port   = var.container_port
    target_group_arn = var.target_group_arn
  }
  network_configuration {
    subnets          = var.subnets
    assign_public_ip = var.assign_public_ip
    security_groups  = [aws_security_group.this.id]
  }
}

resource "aws_security_group" "this" {
  name_prefix = local.name_prefix
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.ingress_security_group]
    description     = "traffic from ALB"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_iam_policy_document" "ecs" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs" {
  assume_role_policy = data.aws_iam_policy_document.ecs.json
  name_prefix        = local.name_prefix
}

resource "aws_iam_role_policy" "ecs" {
  role   = aws_iam_role.ecs.id
  policy = data.aws_iam_policy_document.ecs_role.json

}

data "aws_iam_policy_document" "ecs_role" {
  version = "2012-10-17"
  statement {
    resources = ["*"]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "secretsmanager:GetSecretValue",
      "ecs:StartTelemetrySession"
    ]
  }
}
