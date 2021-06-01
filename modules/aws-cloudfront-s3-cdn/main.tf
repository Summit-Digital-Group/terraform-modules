
data "aws_iam_policy_document" "origin" {
  statement {
    sid       = "S3GetObjectForCloudFront"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.bucket_name}${local.origin_path}*"]
    principals {
      type        = "AWS"
      identifiers = [local.cloudfront_origin_access_identity_iam_arn]
    }
  }
  statement {
    sid       = "S3ListBucketForCloudFront"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${local.bucket_name}"]
    principals {
      type        = "AWS"
      identifiers = [local.cloudfront_origin_access_identity_iam_arn]
    }
  }
}

data "aws_iam_policy_document" "origin_website" {
  statement {
    sid       = "S3GetObjectForCloudFront"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.bucket_name}${local.origin_path}*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = join("", aws_s3_bucket.origin.*.bucket)
  policy = local.iam_policy_document
}

resource "aws_s3_bucket" "origin" {
  bucket        = local.bucket_name
  acl           = "private"
  tags          = local.tags
  force_destroy = var.origin_force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.versioning_enabled
  }
  dynamic "logging" {
    for_each = var.access_log_bucket_name != "" ? [1] : []
    content {
      target_bucket = var.access_log_bucket_name
      target_prefix = "logs/"
    }
  }
  dynamic "website" {
    for_each = local.website_config[var.redirect_all_requests_to == "" ? "default" : "redirect_all"]
    content {
      error_document           = lookup(website.value, "error_document", null)
      index_document           = lookup(website.value, "index_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }
  dynamic "cors_rule" {
    for_each = distinct(compact(concat(var.cors_allowed_origins, var.aliases)))
    content {
      allowed_headers = var.cors_allowed_headers
      allowed_methods = var.cors_allowed_methods
      allowed_origins = [cors_rule.value]
      expose_headers  = var.cors_expose_headers
      max_age_seconds = var.cors_max_age_seconds
    }
  }
}

resource "aws_kms_key" "this" {
  description             = "Used to encrypt s3 bucket: ${local.bucket_name}"
  deletion_window_in_days = 10
}

data "aws_s3_bucket" "origin" {
  depends_on = [aws_s3_bucket.origin]
  bucket     = local.bucket_name
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Terraform Managed - ${local.bucket_name}"
}

module "s3_logging_bucket" {
  source                   = "../aws-s3-log-storage"
  bucket_name              = local.logging_bucket_name
  standard_transition_days = var.log_standard_transition_days
  glacier_transition_days  = var.log_glacier_transition_days
  expiration_days          = var.log_expiration_days
  force_destroy            = var.log_force_destroy
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [aws_s3_bucket.origin, module.s3_logging_bucket]
  tags       = local.tags

  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      dynamic "custom_origin_config" {
        for_each = origin.value.custom_origin_config
        content {
          http_port                = custom_origin_config.value.http_port
          https_port               = custom_origin_config.value.https_port
          origin_protocol_policy   = custom_origin_config.value.origin_protocol_policy
          origin_ssl_protocols     = custom_origin_config.value.origin_ssl_protocols
          origin_keepalive_timeout = custom_origin_config.value.origin_keepalive_timeout
          origin_read_timeout      = custom_origin_config.value.origin_read_timeout
        }
      }
    }
  }
  origin {
    domain_name = data.aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id   = random_pet.origin_id.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Terraform Managed"
  default_root_object = var.default_root_object
  logging_config {
    include_cookies = var.logging.include_cookies
    bucket          = module.s3_logging_bucket.bucket.bucket_regional_domain_name
    prefix          = var.logging.prefix
  }
  aliases = var.aliases
  dynamic "default_cache_behavior" {
    for_each = [var.default_cache]
    content {
      allowed_methods  = try(default_cache_behavior.value["allowed_methods"], ["GET", "HEAD", "OPTIONS"])
      cached_methods   = try(default_cache_behavior.value["cached_methods"], ["GET", "HEAD"])
      target_origin_id = random_pet.origin_id.id
      dynamic "forwarded_values" {
        for_each = try(default_cache_behavior.value["forwarded_values"], [])
        content {
          query_string = forwarded_values.value["query_string"] != null ? forwarded_values.value["query_string"] : false
          headers      = try(forwarded_values.value["headers"], [])
          dynamic "cookies" {
            for_each = try(forwarded_values.value["cookies"], [])
            content {
              forward = cookies.value["forward"] != null ? cookies.value["forward"] : "none"
            }
          }
        }
      }
      dynamic "function_association" {
        for_each = try(default_cache_behavior.value["function_association"], [])
        content {
          event_type   = function_association.value.event_type
          function_arn = function_association.value.function_arn
        }
      }
      dynamic "lambda_function_association" {
        for_each = try(default_cache_behavior.value["lambda_function_association"], [])
        content {
          event_type   = lambda_function_association.value.event_type
          include_body = lambda_function_association.value.include_body
          lambda_arn   = lambda_function_association.value.lambda_arn
        }
      }
      viewer_protocol_policy = try(default_cache_behavior.value["viewer_protocol_policy"], "allow-all")
      min_ttl                = try(default_cache_behavior.value["min_ttl"], 0)
      default_ttl            = try(default_cache_behavior.value["default_ttl"], 3600)
      max_ttl                = try(default_cache_behavior.value["min_ttl"], 86400)
    }
  }
  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behavior
    content {
      path_pattern     = try(ordered_cache_behavior.value["path_pattern"], ["/"])
      allowed_methods  = try(ordered_cache_behavior.value["allowed_methods"], ["GET", "HEAD", "OPTIONS"])
      cached_methods   = try(ordered_cache_behavior.value["cached_methods"], ["GET", "HEAD"])
      target_origin_id = random_pet.origin_id.id
      dynamic "forwarded_values" {
        for_each = try(ordered_cache_behavior.value["forwarded_values"], [])
        content {
          query_string = forwarded_values.value["query_string"] != null ? forwarded_values.value["query_string"] : false
          headers      = try(forwarded_values.value["headers"], [])
          dynamic "cookies" {
            for_each = try(forwarded_values.value["cookies"], [])
            content {
              forward = cookies.value["forward"] != null ? cookies.value["forward"] : "none"
            }
          }
        }
      }
      dynamic "function_association" {
        for_each = try(ordered_cache_behavior.value["function_association"], [])
        content {
          event_type   = function_association.value.event_type
          function_arn = function_association.value.function_arn
        }
      }
      dynamic "lambda_function_association" {
        for_each = try(ordered_cache_behavior.value["lambda_function_association"], [])
        content {
          event_type   = lambda_function_association.value.event_type
          include_body = lambda_function_association.value.include_body
          lambda_arn   = lambda_function_association.value.lambda_arn
        }
      }
      viewer_protocol_policy = try(ordered_cache_behavior.value["viewer_protocol_policy"], "allow-all")
      min_ttl                = try(ordered_cache_behavior.value["min_ttl"], 0)
      default_ttl            = try(ordered_cache_behavior.value["default_ttl"], 3600)
      max_ttl                = try(ordered_cache_behavior.value["min_ttl"], 86400)
    }
  }
  price_class = var.price_class
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }
  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.acm_certificate_arn == "" ? "" : "sni-only"
    minimum_protocol_version       = var.minimum_protocol_version
    cloudfront_default_certificate = var.acm_certificate_arn == "" ? true : false
  }
  dynamic "custom_error_response" {
    for_each = var.custom_error_responses
    content {
      error_code         = custom_error_response.value.error_code
      response_code      = custom_error_response.value.response_code
      response_page_path = custom_error_response.value.response_page_path
    }
  }
}
