locals {
  tags          = merge(var.tags, var.default_tags)
  function_name = var.function_name != "" ? var.function_name : "basic-auth-${formatdate("YYYYMMDD", timestamp())}"
  username      = var.username
  password      = var.password != "" ? var.password : random_password.this.result
}
