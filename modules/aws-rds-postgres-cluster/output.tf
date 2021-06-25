output "cluster" {
  value = aws_rds_cluster.this
}

output "instances" {
  value = aws_rds_cluster_instance.this
}

output "security_group" {
  value = aws_security_group.this
}

output "username" {
  value = aws_rds_cluster.this.master_username
}

output "password" {
  sensitive = true
  value     = aws_rds_cluster.this.master_password
}

