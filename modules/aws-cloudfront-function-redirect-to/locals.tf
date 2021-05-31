locals {
  tags          = merge(var.tags, var.default_tags)
  function_name = var.function_name != "" ? var.function_name : "redirect-to-${formatdate("YYYYMMDD", time_static.this.rfc3339)}"
}
