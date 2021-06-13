
variable "function_name" {
  description = "The name of the function. Defaults to cache-control-date"
  default     = ""
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

variable "duration" {
  description = "The total time to keep the resource users cache."
  default     = "31536000"
}
