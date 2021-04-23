locals {
  bucket_name         = var.bucket_name != "" ? var.bucket_name : random_pet.this.id
  logging_bucket_name = var.logging.bucket_name != "" ? var.logging.bucket_name : random_pet.logging.id
  tags                = merge(var.tags, var.default_tags)
}
