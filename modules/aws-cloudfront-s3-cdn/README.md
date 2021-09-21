<!--- BEGIN_TF_DOCS --->
# aws-cloudfront-s3-cdn

This module will configure a cloudfront endpoint being served from s3 using best practices and common configurations.

Features:
- Logging
    - Saved to encrypted S3
    - Automatic archival and purging of log files
- Lambda@Edge Compatible
- IAM
    - All accounts created with least privileges

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.block_origin_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [random_pet.logging](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.origin_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.origin_website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_bucket_name"></a> [access\_log\_bucket\_name](#input\_access\_log\_bucket\_name) | Name of the S3 bucket where s3 access log will be sent to | `string` | `""` | no |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | Existing ACM Certificate ARN | `string` | n/a | yes |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | The websites being hosted out of this s3 bucket | `list` | `[]` | no |
| <a name="input_aws_s3_origin_block_public_access"></a> [aws\_s3\_origin\_block\_public\_access](#input\_aws\_s3\_origin\_block\_public\_access) | Blocks all public access to the origin bucket | `bool` | `false` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. Defaults to true. Enabling this setting does not affect the existing bucket policy. | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The Amazon S3 bucket to serve as the origin for this cdn. | `string` | `""` | no |
| <a name="input_cloudfront_origin_access_identity_iam_arn"></a> [cloudfront\_origin\_access\_identity\_iam\_arn](#input\_cloudfront\_origin\_access\_identity\_iam\_arn) | Existing cloudfront origin access identity iam arn that is supplied in the s3 bucket policy | `string` | `""` | no |
| <a name="input_cloudfront_origin_access_identity_path"></a> [cloudfront\_origin\_access\_identity\_path](#input\_cloudfront\_origin\_access\_identity\_path) | Existing cloudfront origin access identity path used in the cloudfront distribution's s3\_origin\_config content | `string` | `""` | no |
| <a name="input_cors_allowed_headers"></a> [cors\_allowed\_headers](#input\_cors\_allowed\_headers) | List of allowed headers for S3 bucket | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_cors_allowed_methods"></a> [cors\_allowed\_methods](#input\_cors\_allowed\_methods) | List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket | `list(string)` | <pre>[<br>  "GET"<br>]</pre> | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | List of allowed origins (e.g. example.com, test.com) for S3 bucket | `list(string)` | `[]` | no |
| <a name="input_cors_expose_headers"></a> [cors\_expose\_headers](#input\_cors\_expose\_headers) | List of expose header in the response for S3 bucket | `list(string)` | <pre>[<br>  "ETag"<br>]</pre> | no |
| <a name="input_cors_max_age_seconds"></a> [cors\_max\_age\_seconds](#input\_cors\_max\_age\_seconds) | Time in seconds that browser can cache the response for S3 bucket | `number` | `3600` | no |
| <a name="input_custom_error_responses"></a> [custom\_error\_responses](#input\_custom\_error\_responses) | Customized error responses can be defined for any HTTP status code designated as an error condition - that is, any 4xx or 5xx status. | `list` | `[]` | no |
| <a name="input_custom_origin_headers"></a> [custom\_origin\_headers](#input\_custom\_origin\_headers) | A list of origin header parameters that will be sent to origin | `list(object({ name = string, value = string }))` | `[]` | no |
| <a name="input_default_cache"></a> [default\_cache](#input\_default\_cache) | n/a | `map` | <pre>{<br>  "allowed_methods": [<br>    "GET",<br>    "HEAD",<br>    "OPTIONS"<br>  ],<br>  "cached_methods": [<br>    "GET",<br>    "HEAD"<br>  ],<br>  "default_ttl": 3600,<br>  "forwarded_values": [<br>    {<br>      "cookies": [<br>        {<br>          "forward": "none"<br>        }<br>      ],<br>      "query_string": false<br>    }<br>  ],<br>  "max_ttl": 86400,<br>  "min_ttl": 0,<br>  "viewer_protocol_policy": "redirect-to-https"<br>}</pre> | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | Object that CloudFront return when requests the root URL | `string` | `"index.html"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags to apply to all resources being generated | `map` | `{}` | no |
| <a name="input_enable_custom_kms_key_encryption"></a> [enable\_custom\_kms\_key\_encryption](#input\_enable\_custom\_kms\_key\_encryption) | Enable and provision kms key for s3 encryption | `bool` | `false` | no |
| <a name="input_error_document"></a> [error\_document](#input\_error\_document) | An absolute path to the document to return in case of a 4XX error | `string` | `""` | no |
| <a name="input_geo_restriction_locations"></a> [geo\_restriction\_locations](#input\_geo\_restriction\_locations) | List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | `list(string)` | `[]` | no |
| <a name="input_geo_restriction_type"></a> [geo\_restriction\_type](#input\_geo\_restriction\_type) | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | `string` | `"none"` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to true. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. | `bool` | `true` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders | `string` | `"index.html"` | no |
| <a name="input_kms_key_deletion_window_in_days"></a> [kms\_key\_deletion\_window\_in\_days](#input\_kms\_key\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 10 days. | `number` | `10` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Uses an already existing kms key for encrytping contents | `string` | `""` | no |
| <a name="input_log_expiration_days"></a> [log\_expiration\_days](#input\_log\_expiration\_days) | Number of days after which to expunge the objects from glacier storage | `number` | `365` | no |
| <a name="input_log_force_destroy"></a> [log\_force\_destroy](#input\_log\_force\_destroy) | Applies to log bucket created by this module only. If true, all objects will be deleted from the bucket on destroy, so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_log_glacier_transition_days"></a> [log\_glacier\_transition\_days](#input\_log\_glacier\_transition\_days) | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| <a name="input_log_standard_transition_days"></a> [log\_standard\_transition\_days](#input\_log\_standard\_transition\_days) | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| <a name="input_log_versioning_enabled"></a> [log\_versioning\_enabled](#input\_log\_versioning\_enabled) | When true, the access logs bucket will be versioned | `bool` | `false` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | The Amazon S3 bucket to save logs into | `map` | <pre>{<br>  "bucket_name": "",<br>  "include_cookies": false,<br>  "prefix": ""<br>}</pre> | no |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | Cloudfront TLS minimum protocol version. See [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html#secure-connections-supported-ciphers) for more information. | `string` | `"TLSv1.2_2019"` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | n/a | `any` | `null` | no |
| <a name="input_origin_force_destroy"></a> [origin\_force\_destroy](#input\_origin\_force\_destroy) | Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`) | `bool` | `false` | no |
| <a name="input_origin_path"></a> [origin\_path](#input\_origin\_path) | An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path. | `string` | `""` | no |
| <a name="input_origin_ssl_protocols"></a> [origin\_ssl\_protocols](#input\_origin\_ssl\_protocols) | The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. | `list(string)` | <pre>[<br>  "TLSv1",<br>  "TLSv1.1",<br>  "TLSv1.2"<br>]</pre> | no |
| <a name="input_origins"></a> [origins](#input\_origins) | One or more origins for this distribution (multiples allowed). | `any` | `null` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | `string` | `"PriceClass_100"` | no |
| <a name="input_redirect_all_requests_to"></a> [redirect\_all\_requests\_to](#input\_redirect\_all\_requests\_to) | A hostname to redirect all website requests for this distribution to. If this is set, it overrides other website settings | `string` | `""` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to true. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked | `bool` | `true` | no |
| <a name="input_routing_rules"></a> [routing\_rules](#input\_routing\_rules) | A json array containing routing rules describing redirect behavior and when redirects are applied | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources being generated | `map` | `{}` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | When set to 'true' the s3 origin bucket will have versioning enabled | `bool` | `true` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution. To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws\_wafv2\_web\_acl.example.arn. To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws\_waf\_web\_acl.example.id. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cloudfront_distribution"></a> [aws\_cloudfront\_distribution](#output\_aws\_cloudfront\_distribution) | n/a |
| <a name="output_aws_cloudfront_origin_access_identity"></a> [aws\_cloudfront\_origin\_access\_identity](#output\_aws\_cloudfront\_origin\_access\_identity) | n/a |
| <a name="output_aws_kms_key"></a> [aws\_kms\_key](#output\_aws\_kms\_key) | n/a |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | n/a |
| <a name="output_s3_bucket_logging"></a> [s3\_bucket\_logging](#output\_s3\_bucket\_logging) | n/a |

<!--- END_TF_DOCS --->
