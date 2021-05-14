
variable "name_prefix" {
  description = "Prefix to be used when creating the lambda and iam roles associated with it. Defaults to random pet name."
  default     = ""
}
variable "lambda_name" {
  description = "Default lambda name after the prexi."
  default     = "basic-auth"
}

variable "tags" {
  description = "Tags to apply to all resources being generated"
  default     = {}
}

variable "retention_in_days" {
  description = "Number of days to retain lambda logs in cloudwatch"
  default     = 30
}

variable "default_tags" {
  description = "Tags to apply to all resources being generated"
  default = {
  }
}

variable "username" {
  description = "The name to use when authenticating"
  type        = string
}

variable "password" {
  description = "The password to use when authenticating. If left blank a password will be generated automatically."
  type        = string
  default     = ""
}

variable "realm" {
  description = "The name of the realm to associate with this auth lambda"
  default     = "Realm"
}
