locals {
  tags          = merge(var.tags, var.default_tags)
  function_name = var.function_name != "" ? var.function_name : "auth-redirect-${formatdate("YYYYMMDD", time_static.this.rfc3339)}"
  username      = var.username
  password      = var.password != "" ? var.password : random_password.this.result
}
