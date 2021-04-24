locals {
  bucket_name                               = var.bucket_name != "" ? var.bucket_name : random_pet.this.id
  logging_bucket_name                       = var.logging.bucket_name != "" ? var.logging.bucket_name : random_pet.logging.id
  tags                                      = merge(var.tags, var.default_tags)
  origin_path                               = coalesce(var.origin_path, "/")
  iam_policy_document                       = try(data.aws_iam_policy_document.origin_website.json, "")
  using_existing_cloudfront_origin          = var.cloudfront_origin_access_identity_iam_arn != "" && var.cloudfront_origin_access_identity_path != ""
  cloudfront_origin_access_identity_iam_arn = local.using_existing_cloudfront_origin ? var.cloudfront_origin_access_identity_iam_arn : join("", aws_cloudfront_origin_access_identity.origin_access_identity.*.iam_arn)
  website_config = {
    redirect_all = [
      {
        redirect_all_requests_to = var.redirect_all_requests_to
      }
    ]
    default = [
      {
        index_document = var.index_document
        error_document = var.error_document
        routing_rules  = var.routing_rules
      }
    ]
  }
}
