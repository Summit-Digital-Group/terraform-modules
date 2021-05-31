locals {
  host_port      = var.host_port != "" ? var.host_port : var.container_port
  awslogs_prefix = var.awslogs_prefix != "" ? var.awslogs_prefix : var.container_name
  name_prefix    = var.name_prefix != "" ? var.name_prefix : var.container_name
}
