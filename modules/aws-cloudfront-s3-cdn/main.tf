

resource "aws_s3_bucket" "this" {
  count  = var.bucket_name == "" ? 1 : 0
  bucket = local.bucket_name
  acl    = "private"
  tags   = local.tags
}

data "aws_s3_bucket" "selected" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket" "logging" {
  count  = var.logging.bucket_name == "" ? 1 : 0
  bucket = local.logging_bucket_name
  acl    = "private"
  tags   = local.tags
  lifecycle {

  }
}

data "aws_s3_bucket" "logging" {
  bucket = local.bucket_name
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Terraform Managed"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = data.aws_s3_bucket.selected.bucket_regional_domain_name
    origin_id   = random_pet.origin_id.id
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Terraform Managed"
  default_root_object = "index.html"
  logging_config {
    include_cookies = var.logging.include_cookies
    bucket          = data.aws_s3_bucket.logging.id
    prefix          = var.logging.prefix
  }
  aliases = var.aliases
  dynamic "default_cache_behavior" {
    for_each = [var.default_cache]
    content {
      allowed_methods  = default_cache_behavior.value["allowed_methods"] != null ? default_cache_behavior.value["viewer_protocol_policy"] : ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
      cached_methods   = default_cache_behavior.value["cached_methods"] != null ? default_cache_behavior.value["viewer_protocol_policy"] : ["GET", "HEAD"]
      target_origin_id = random_pet.origin_id.id
      dynamic "forwarded_values" {
        for_each = default_cache_behavior.value["forwarded_values"]
        content {
          query_string = forwarded_values.value["query_string"] != null ? forwarded_values.value["query_string"] : false
          headers      = forwarded_values.value["headers"]
          dynamic "cookies" {
            for_each = forwarded_values.value["cookies"]
            content {
              forward = cookies.value["forward"] != null ? cookies.value["forward"] : "none"
            }
          }
        }
      }
      dynamic "lambda_function_association" {
        for_each = default_cache_behavior.value["lambda_function_association"]
        content {
          event_type   = lambda_function_association.value.event_type
          include_body = lookup(lambda_function_association.value, "include_body", null)
          lambda_arn   = lambda_function_association.value.lambda_arn
        }
      }
      viewer_protocol_policy = default_cache_behavior.value["viewer_protocol_policy"] != null ? default_cache_behavior.value["viewer_protocol_policy"] : "allow-all"
      min_ttl                = default_cache_behavior.value["min_ttl"] != null ? default_cache_behavior.value["min_ttl"] : 0
      default_ttl            = default_cache_behavior.value["default_ttl"] != null ? default_cache_behavior.value["default_ttl"] : 3600
      max_ttl                = default_cache_behavior.value["min_ttl"] != null ? default_cache_behavior.value["default_ttl"] : 86400
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }
  price_class = var.price_class
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }
  tags = local.tags
  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.acm_certificate_arn == "" ? "" : "sni-only"
    minimum_protocol_version       = var.minimum_protocol_version
    cloudfront_default_certificate = var.acm_certificate_arn == "" ? true : false
  }
}
