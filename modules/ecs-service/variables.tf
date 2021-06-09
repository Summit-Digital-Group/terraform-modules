variable "ecs_cluster_id" {
  description = "The cluster to add this service to."
}

variable "container_port" {
  description = "The port to map incoming traffic to on the container"
}

variable "host_port" {
  description = "The port to map incoming traffic to on the ecs host"
  default     = null
}

variable "container_name" {
  description = "The name you want to use to describe the container"
}

variable "container_image" {
  description = "The url location of the container image to use"
}

variable "cpu" {
  description = "The total amount of cpu resources available to this container"
  default     = 256
}

variable "memory" {
  description = "The total amount of memory resources available to this container"
  default     = 512
}

variable "region" {
  description = "The aws region to create the resources in."
  default     = "us-east-1"
}

variable "awslogs_group" {
  description = "The name of the logs group to send log event to."
}

variable "awslogs_prefix" {
  description = "The prefix to use when sending log events to the logs group."
}

variable "aws_ecs_cluster_name" {
  description = "The ecs cluster to associate this ecs-service with"
}

variable "subnets" {
  description = "The subnets to use for the alb traffic and security group config"
}

variable "target_group_arn" {
  description = "The target"
}

variable "vpc_id" {
  description = "The vpc id to associate with network resources."
}

variable "name_prefix" {
  description = "Default prefix to use when creating resources. If none provided use container name."
  default     = ""
}

variable "ingress_security_group" {
  description = "AWS ALB security group to use with ecs service network  configuration"
}

variable "secrets" {
  default = []
}

variable "environment_vars" {
  default = [
    {
      name  = "NODE_ENV"
      value = "production"
    },
    { name  = "NO_COLOR"
      value = "true"
    }
  ]
}

variable "tags" {
  default = {}
}

variable "force_new_deployment" {
  description = "Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination"
  default     = false
}
