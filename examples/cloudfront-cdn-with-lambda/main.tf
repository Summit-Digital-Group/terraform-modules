module "current_website" {
  source               = "../../modules/aws-cloudfront-s3-cdn"
  aliases              = ["cloudfront-test.acme.com"]
  acm_certificate_arn  = "arn:::::::"
  cors_allowed_headers = ["*"]
  cors_allowed_methods = ["GET", "HEAD", "OPTION"]
  cors_allowed_origins = [""]
  cors_expose_headers  = ["ETag"]
  default_cache = {
    lambda_function_association = [module.lambda_at_edge]
  }
}

module "lambda_at_edge" {
  source            = "../../modules/aws-lambda-edge-cache-header"
  retention_in_days = 1
}
