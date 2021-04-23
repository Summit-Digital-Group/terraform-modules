output "s3_bucket" {
  value = data.aws_s3_bucket.selected
}

output "s3_bucket_logging" {
  value = data.aws_s3_bucket.logging
}
