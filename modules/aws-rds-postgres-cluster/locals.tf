locals {
  username = var.username != "" ? var.username : "postgres"
  password = var.password != "" ? var.password : random_password.this.result
}
