locals {
  tags     = merge(var.tags, var.default_tags)
  username = var.username
  password = var.password != "" ? var.password : random_password.this.result
}
