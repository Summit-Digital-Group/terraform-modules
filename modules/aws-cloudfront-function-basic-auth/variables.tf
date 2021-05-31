
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
