resource "time_static" "this" {}

resource "aws_cloudfront_function" "this" {
  name    = local.function_name
  runtime = "cloudfront-js-1.0"
  comment = "cache_headers"
  publish = true
  code    = templatefile("${path.module}/function.js", { duration = var.duration })
}
