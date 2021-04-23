variable "aliases" {
  description = "The websites being hosted out of this s3 bucket"
  default     = ["demo.example.com", "demo-2.example.com"]
}

variable "bucket_name" {
  description = "The Amazon S3 bucket to serve as the origin for this cdn."
  default     = ""
}

variable "logging" {
  description = "The Amazon S3 bucket to save logs into"
  default = {
    bucket_name     = ""
    prefix          = ""
    include_cookies = false
  }
}

variable "tags" {
  description = "Tags to apply to all resources being generated"
  default     = {}
}

variable "default_tags" {
  description = "Tags to apply to all resources being generated"
  default = {
    private = true
  }
}

variable "default_cache" {
  description = ""
  default = {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values = [{
      query_string = false
      cookies = [{
        forward = "none"
      }]
    }]
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}

variable "geo_restriction_type" {
  type = string
  # e.g. "whitelist"
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type = list(string)
  # e.g. ["US", "CA", "GB", "DE"]
  default     = []
  description = "List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}
