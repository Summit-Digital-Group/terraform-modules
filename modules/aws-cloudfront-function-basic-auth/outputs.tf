output "arn" {
  value = aws_cloudfront_function.this.arn
}

output "qualified_arn" {
  value = aws_cloudfront_function.this.qualified_arn
}

output "event_type" {
  value = "viewer-request"
}

output "include_body" {
  value = false
}

output "username" {
  sensitive = true
  value     = local.username
}

output "password" {
  sensitive = true
  value     = local.password
}
