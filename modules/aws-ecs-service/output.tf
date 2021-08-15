output "ecs_service" {
  value = aws_ecs_service.this
}
output "ecs_service_name" {
  value = aws_ecs_service.this.name
}
output "ecs_task_definition" {
  value = aws_ecs_task_definition.this
}
output "security_group" {
  value = aws_security_group.this
}

