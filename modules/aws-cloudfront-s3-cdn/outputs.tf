output "s3_bucket" {
  value = data.aws_s3_bucket.origin
}

output "s3_bucket_logging" {
  value = module.s3_logging_bucket.bucket
}

output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.s3_distribution
}

output "aws_cloudfront_origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.origin_access_identity
}

output "aws_kms_key" {
  value = aws_kms_key.this
}
