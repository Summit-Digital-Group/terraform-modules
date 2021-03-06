resource "aws_kms_key" "this" {
  description             = "Used to encrypt s3 bucket: ${local.bucket_name}"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "default" {
  #bridgecrew:skip=BC_AWS_S3_13:Skipping `Enable S3 Bucket Logging` check until bridgecrew will support dynamic blocks (https://github.com/bridgecrewio/checkov/issues/776).
  #bridgecrew:skip=CKV_AWS_52:Skipping `Ensure S3 bucket has MFA delete enabled` due to issue in terraform (https://github.com/hashicorp/terraform-provider-aws/issues/629).
  bucket        = local.bucket_name
  acl           = var.acl
  force_destroy = var.force_destroy
  policy        = var.policy
  versioning {
    enabled = var.versioning_enabled
  }
  lifecycle_rule {
    id                                     = local.bucket_name
    enabled                                = var.lifecycle_rule_enabled
    prefix                                 = var.lifecycle_prefix
    tags                                   = var.lifecycle_tags
    abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload_days
    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration_days
    }
    dynamic "noncurrent_version_transition" {
      for_each = var.enable_glacier_transition ? [1] : []
      content {
        days          = var.noncurrent_version_transition_days
        storage_class = "GLACIER"
      }
    }
    transition {
      days          = var.standard_transition_days
      storage_class = "STANDARD_IA"
    }
    dynamic "transition" {
      for_each = var.enable_glacier_transition ? [1] : []
      content {
        days          = var.glacier_transition_days
        storage_class = "GLACIER"
      }
    }
    expiration {
      days = var.expiration_days
    }
  }

  dynamic "logging" {
    for_each = var.access_log_bucket_name != "" ? [1] : []
    content {
      target_bucket = var.access_log_bucket_name
      target_prefix = "logs/"
    }
  }

  # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
  # https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#enable-default-server-side-encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.this.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = local.tags
}

# Refer to the terraform documentation on s3_bucket_public_access_block at
# https://www.terraform.io/docs/providers/aws/r/s3_bucket_public_access_block.html
# for the nuances of the blocking options
resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
