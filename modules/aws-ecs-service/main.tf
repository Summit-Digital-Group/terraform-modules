module "this_container_def" {
  source                       = "cloudposse/ecs-container-definition/aws"
  container_name               = var.container_name
  container_image              = var.container_image
  readonly_root_filesystem     = var.readonly_root_filesystem
  environment                  = var.environment_vars
  secrets                      = var.secrets
  port_mappings                = [{ containerPort : var.container_port, hostPort : local.host_port, protocol : "tcp" }]
  container_cpu                = var.cpu
  container_memory_reservation = var.memory
  log_configuration = var.logging_enabled ? {
    logDriver = "awslogs"
    options = {
      "awslogs-region"        = var.region
      "awslogs-group"         = var.awslogs_group
      "awslogs-stream-prefix" = local.awslogs_prefix
    }
  } : null
}

module "container_sidecar_defs" {
  count                        = var.sidecar_enabled != false ? 1 : 0
  source                       = "cloudposse/ecs-container-definition/aws"
  container_name               = var.container_sidecar_def.container_name
  container_image              = var.container_sidecar_def.container_image
  readonly_root_filesystem     = try(var.container_sidecar_def.readonly_root_filesystem, true)
  environment                  = try(var.container_sidecar_def.environment_vars, null)
  secrets                      = try(var.container_sidecar_def.secrets, null)
  port_mappings                = [{ containerPort : var.container_sidecar_def.container_port, hostPort : var.container_sidecar_def.host_port, protocol : "tcp" }]
  container_cpu                = local.sidecar_cpu
  container_memory_reservation = local.sidecar_memory
  log_configuration = try(var.container_sidecar_def.logging_enabled, false) ? {
    logDriver = "awslogs"
    options = {
      "awslogs-region"        = var.region
      "awslogs-group"         = try(var.container_sidecar_def.awslogs_group, var.awslogs_group)
      "awslogs-stream-prefix" = var.container_sidecar_def.awslogs_prefix
    }
  } : null
}

resource "aws_ecs_task_definition" "this" {
  execution_role_arn       = aws_iam_role.ecs.arn
  task_role_arn            = aws_iam_role.ecs.arn
  family                   = local.name_prefix
  requires_compatibilities = var.requires_compatibilities
  network_mode             = "awsvpc"
  cpu                      = local.total_cpu
  memory                   = local.total_memory
  tags                     = var.tags
  container_definitions    = <<EOF
    [${module.this_container_def.json_map_encoded},${module.container_sidecar_defs[0].json_map_encoded}]
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
  enable_execute_command             = var.enable_execute_command
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  force_new_deployment = var.force_new_deployment
  tags                 = var.tags
  load_balancer {
    container_name   = var.load_balancer_container_name != "" ? var.load_balancer_container_name : var.container_name
    container_port   = var.load_balancer_container_port != "" ? var.load_balancer_container_port : var.container_port
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
  policy = data.aws_iam_policy_document.ecs_task_role.json

}

data "aws_iam_policy_document" "ecs_task_role" {
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
      "ecs:StartTelemetrySession",
      "s3:*"
    ]
  }
}
