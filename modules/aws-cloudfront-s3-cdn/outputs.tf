output "s3_bucket" {
  value = data.aws_s3_bucket.origin
}

output "s3_bucket_logging" {
  value = module.s3_logging_bucket.bucket
}
