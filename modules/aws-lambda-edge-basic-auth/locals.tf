locals {
  name_prefix         = var.name_prefix != "" ? var.name_prefix : random_pet.this.id
  lambda_name         = "${local.name_prefix}-${var.lambda_name}"
  archive_output_path = "${path.module}/handler.zip"
  tags                = merge(var.tags, var.default_tags)
  username            = var.username
  password            = var.password != "" ? var.password : random_password.this.result
}
