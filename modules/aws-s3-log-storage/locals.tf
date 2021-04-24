locals {
  bucket_name = var.bucket_name != "" ? var.bucket_name : random_pet.this.id
  tags        = merge(var.tags, var.default_tags)
}
