
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

resource "aws_s3_bucket_public_access_block" "origin" {
  count                   = var.block_origin_public_access_enabled ? 1 : 0
  bucket                  = local.bucket_name
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  # Don't ty and modify this bucket in two ways at the same time, S3 API will
  # complain.
  depends_on = [aws_s3_bucket_policy.default]
}

data "aws_s3_bucket" "origin" {
  depends_on = [aws_s3_bucket.origin]
  bucket     = local.bucket_name
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Terraform Managed"
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
      allowed_methods  = try(default_cache_behavior.value["allowed_methods"], ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"])
      cached_methods   = try(default_cache_behavior.value["cached_methods"], ["GET", "HEAD"])
      target_origin_id = random_pet.origin_id.id
      dynamic "forwarded_values" {
        for_each = default_cache_behavior.value["forwarded_values"]
        content {
          query_string = forwarded_values.value["query_string"] != null ? forwarded_values.value["query_string"] : false
          headers      = try(forwarded_values.value["headers"], [])
          dynamic "cookies" {
            for_each = forwarded_values.value["cookies"]
            content {
              forward = cookies.value["forward"] != null ? cookies.value["forward"] : "none"
            }
          }
        }
      }
      dynamic "lambda_function_association" {
        for_each = try(default_cache_behavior.value["lambda_function_association"], [])
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
