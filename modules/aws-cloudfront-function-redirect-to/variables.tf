
variable "function_name" {
  description = "Default lambda name after the prexi."
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

variable "target" {
  description = "The full url to redirect to on path match. Example: https://www.example.com"
}

variable "path" {
  description = "Has to match this path to be redirected to target"
  default     = "/"
}
