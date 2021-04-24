variable "max_age" {
  description = "The maximum age to keep content locally cached with the cache-control header. Should be in ms"
  default     = "31536000"
}

variable "name_prefix" {
  description = "Prefix to be used when creating the lambda and iam roles associated with it. Defaults to random pet name."
  default     = ""
}
variable "lambda_name" {
  description = "Default lambda name after the prexi."
  default     = "edge-cache-header"
}

variable "retention_in_days" {
  description = "Number of days to retain lambda logs in cloudwatch"
  default     = 30
}

variable "tags" {
  description = "Tags to apply to all resources being generated"
  default     = {}
}

variable "default_tags" {
  description = "Tags to apply to all resources being generated"
  default = {
  }
}
