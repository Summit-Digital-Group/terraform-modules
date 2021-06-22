data "aws_subnet_ids" "this" {
  vpc_id = var.vpc_id
}


resource "aws_db_subnet_group" "this" {
  name_prefix = var.cluster_identifier
  subnet_ids  = data.aws_subnet_ids.this.ids
  tags        = var.tags
}

resource "aws_security_group" "this" {
  name_prefix = var.cluster_identifier
  description = "Allow inbound traffic to the database cluster"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
    cidr_blocks = var.vpc_cidrs
  }
  tags = var.tags
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  master_username         = local.username
  master_password         = local.password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  storage_encrypted       = var.storage_encrypted
}

resource "aws_rds_cluster_instance" "this" {
  lifecycle {
    ignore_changes = [engine_version]
  }
  publicly_accessible = var.publicly_accessible
  count               = var.instances
  identifier          = "${var.cluster_identifier}-${count.index}"
  cluster_identifier  = aws_rds_cluster.this.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.this.engine
  engine_version      = aws_rds_cluster.this.engine_version
}

resource "random_password" "this" {
  length = 32
}
