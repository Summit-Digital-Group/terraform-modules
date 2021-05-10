output "lambda" {
  value = aws_lambda_function.this
}

output "name" {
  value = local.lambda_name
}

output "arn" {
  value = aws_lambda_function.this.arn
}


output "qualified_arn" {
  value = aws_lambda_function.this.qualified_arn
}

output "event_type" {
  value = "viewer-response"
}

output "include_body" {
  value = false
}

output "lambda_arn" {
  value = aws_lambda_function.this.qualified_arn
}

output "username" {
  sensitive = true
  value     = local.username
}

output "password" {
  sensitive = true
  value     = local.password
}
