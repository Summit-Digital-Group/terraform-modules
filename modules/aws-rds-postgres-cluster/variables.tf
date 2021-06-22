variable "cluster_identifier" {
  description = ""
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to create the RDS resources within"
  type        = string
}

variable "vpc_cidrs" {
  description = "List of cidr blocks to allow traffic to originate from."
  type        = list(any)
}

variable "publicly_accessible" {
  description = "If set to true will allow external traffic to be able to access these instances. See the documentation on Creating DB Instances for more details on controlling this property. https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html"
  default     = false
}
variable "availability_zones" {
  default = [""]
}

variable "username" {
  description = "The username to use for the root account."
  default     = "postgres"
}

variable "password" {
  description = "The password to use for the root account. Defaults to a randomly generated password."
  default     = ""
}

variable "backup_retention_period" {
  default = 4
}

variable "preferred_backup_window" {
  default = "07:00-09:00"
}

variable "instances" {
  description = "The total number of instances that are provisioned with this cluster."
  default     = 2
}

variable "instance_class" {
  description = "The instance class to use. For details on CPU and memory. See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html"
  default     = "db.m5.large"
}

variable "database_name" {
  description = "The default database to be created when provisioning the RDS cluster."
  default     = "postgres"
}

variable "tags" {
  default = {}
}
