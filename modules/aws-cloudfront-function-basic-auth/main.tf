resource "random_password" "this" {
  length = 10
}

resource "time_static" "this" {}

resource "aws_cloudfront_function" "this" {
  name    = local.function_name
  runtime = "cloudfront-js-1.0"
  comment = "basic_authentication"
  publish = true
  code    = templatefile("${path.module}/function.js", { username = local.username, password = local.password })
}
