output "arn" {
  value = aws_cloudfront_function.this.arn
}

output "function_arn" {
  value = aws_cloudfront_function.this.arn
}

output "event_type" {
  value = "viewer-response"
}

output "include_body" {
  value = false
}
