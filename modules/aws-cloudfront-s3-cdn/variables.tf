variable "aliases" {
  description = "The websites being hosted out of this s3 bucket"
  default     = []
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
variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
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

variable "default_cache" {
  description = ""
  default = {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values = [{
      query_string = false
      cookies = [{
        forward = "none"
      }]
    }]
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}
variable "ordered_cache_behavior" {
  description = ""
  default     = null
}

variable "origins" {
  description = "One or more origins for this distribution (multiples allowed)."
  default     = null
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

variable "origin_force_destroy" {
  type        = bool
  default     = false
  description = "Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`)"
}

variable "log_versioning_enabled" {
  type        = bool
  default     = false
  description = "When true, the access logs bucket will be versioned"
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the s3 origin bucket will have versioning enabled"
}

variable "cloudfront_origin_access_identity_iam_arn" {
  type        = string
  default     = ""
  description = "Existing cloudfront origin access identity iam arn that is supplied in the s3 bucket policy"
}

variable "cloudfront_origin_access_identity_path" {
  type        = string
  default     = ""
  description = "Existing cloudfront origin access identity path used in the cloudfront distribution's s3_origin_config content"
}

variable "custom_origin_headers" {
  type        = list(object({ name = string, value = string }))
  default     = []
  description = "A list of origin header parameters that will be sent to origin"
}

variable "access_log_bucket_name" {
  type        = string
  default     = ""
  description = "Name of the S3 bucket where s3 access log will be sent to"
}

variable "cors_allowed_headers" {
  type        = list(string)
  default     = ["*"]
  description = "List of allowed headers for S3 bucket"
}

variable "cors_allowed_methods" {
  type        = list(string)
  default     = ["GET"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket"
}

variable "cors_allowed_origins" {
  type        = list(string)
  default     = []
  description = "List of allowed origins (e.g. example.com, test.com) for S3 bucket"
}

variable "cors_expose_headers" {
  type        = list(string)
  default     = ["ETag"]
  description = "List of expose header in the response for S3 bucket"
}

variable "cors_max_age_seconds" {
  type        = number
  default     = 3600
  description = "Time in seconds that browser can cache the response for S3 bucket"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
}

variable "minimum_protocol_version" {
  type        = string
  description = "Cloudfront TLS minimum protocol version. See [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html#secure-connections-supported-ciphers) for more information."
  default     = "TLSv1.2_2019"
}

variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders"
}
variable "origin_ssl_protocols" {
  type        = list(string)
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS."
}

variable "redirect_all_requests_to" {
  type        = string
  default     = ""
  description = "A hostname to redirect all website requests for this distribution to. If this is set, it overrides other website settings"
}

variable "error_document" {
  type        = string
  default     = ""
  description = "An absolute path to the document to return in case of a 4XX error"
}

variable "routing_rules" {
  type        = string
  default     = ""
  description = "A json array containing routing rules describing redirect behavior and when redirects are applied"
}

variable "origin_path" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath
  type        = string
  description = "An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path."
  default     = ""
}

variable "log_standard_transition_days" {
  type        = number
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  default     = 30
}

variable "log_glacier_transition_days" {
  type        = number
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = 60
}

variable "log_expiration_days" {
  type        = number
  description = "Number of days after which to expunge the objects from glacier storage"
  default     = 365
}

variable "log_force_destroy" {
  type        = bool
  description = "Applies to log bucket created by this module only. If true, all objects will be deleted from the bucket on destroy, so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}
