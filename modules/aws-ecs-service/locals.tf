locals {
  host_port      = var.host_port != "" ? var.host_port : var.container_port
  awslogs_prefix = var.awslogs_prefix != "" ? var.awslogs_prefix : var.container_name
  name_prefix    = var.name_prefix != "" ? var.name_prefix : var.container_name
  sidecar_cpu    = var.sidecar_enabled ? try(var.container_sidecar_def.cpu, var.cpu) : 0
  sidecar_memory = var.sidecar_enabled ? try(var.container_sidecar_def.memory, var.memory) : 0
  total_cpu      = var.cpu + local.sidecar_cpu
  total_memory   = var.memory + local.sidecar_memory
  container_defs = var.sidecar_enabled ? "[${module.this_container_def.json_map_encoded},${module.container_sidecar_defs[0].json_map_encoded}]" : "[${module.this_container_def.json_map_encoded}]"
}
