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
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_log\_bucket\_name | Name of the S3 bucket where s3 access log will be sent to | `string` | `""` | no |
| acm\_certificate\_arn | Existing ACM Certificate ARN | `string` | n/a | yes |
| aliases | The websites being hosted out of this s3 bucket | `list` | `[]` | no |
| bucket\_name | The Amazon S3 bucket to serve as the origin for this cdn. | `string` | `""` | no |
| cloudfront\_origin\_access\_identity\_iam\_arn | Existing cloudfront origin access identity iam arn that is supplied in the s3 bucket policy | `string` | `""` | no |
| cloudfront\_origin\_access\_identity\_path | Existing cloudfront origin access identity path used in the cloudfront distribution's s3\_origin\_config content | `string` | `""` | no |
| cors\_allowed\_headers | List of allowed headers for S3 bucket | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| cors\_allowed\_methods | List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket | `list(string)` | <pre>[<br>  "GET"<br>]</pre> | no |
| cors\_allowed\_origins | List of allowed origins (e.g. example.com, test.com) for S3 bucket | `list(string)` | `[]` | no |
| cors\_expose\_headers | List of expose header in the response for S3 bucket | `list(string)` | <pre>[<br>  "ETag"<br>]</pre> | no |
| cors\_max\_age\_seconds | Time in seconds that browser can cache the response for S3 bucket | `number` | `3600` | no |
| custom\_origin\_headers | A list of origin header parameters that will be sent to origin | `list(object({ name = string, value = string }))` | `[]` | no |
| default\_cache | n/a | `map` | <pre>{<br>  "allowed_methods": [<br>    "GET",<br>    "HEAD",<br>    "OPTIONS"<br>  ],<br>  "cached_methods": [<br>    "GET",<br>    "HEAD"<br>  ],<br>  "default_ttl": 3600,<br>  "forwarded_values": [<br>    {<br>      "cookies": [<br>        {<br>          "forward": "none"<br>        }<br>      ],<br>      "query_string": false<br>    }<br>  ],<br>  "max_ttl": 86400,<br>  "min_ttl": 0,<br>  "viewer_protocol_policy": "redirect-to-https"<br>}</pre> | no |
| default\_root\_object | Object that CloudFront return when requests the root URL | `string` | `"index.html"` | no |
| default\_tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| error\_document | An absolute path to the document to return in case of a 4XX error | `string` | `""` | no |
| geo\_restriction\_locations | List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | `list(string)` | `[]` | no |
| geo\_restriction\_type | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | `string` | `"none"` | no |
| index\_document | Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders | `string` | `"index.html"` | no |
| log\_expiration\_days | Number of days after which to expunge the objects from glacier storage | `number` | `365` | no |
| log\_force\_destroy | Applies to log bucket created by this module only. If true, all objects will be deleted from the bucket on destroy, so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| log\_glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| log\_standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| log\_versioning\_enabled | When true, the access logs bucket will be versioned | `bool` | `false` | no |
| logging | The Amazon S3 bucket to save logs into | `map` | <pre>{<br>  "bucket_name": "",<br>  "include_cookies": false,<br>  "prefix": ""<br>}</pre> | no |
| minimum\_protocol\_version | Cloudfront TLS minimum protocol version. See [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html#secure-connections-supported-ciphers) for more information. | `string` | `"TLSv1.2_2019"` | no |
| origin\_force\_destroy | Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`) | `bool` | `false` | no |
| origin\_path | An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path. | `string` | `""` | no |
| origin\_ssl\_protocols | The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. | `list(string)` | <pre>[<br>  "TLSv1",<br>  "TLSv1.1",<br>  "TLSv1.2"<br>]</pre> | no |
| price\_class | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | `string` | `"PriceClass_100"` | no |
| redirect\_all\_requests\_to | A hostname to redirect all website requests for this distribution to. If this is set, it overrides other website settings | `string` | `""` | no |
| routing\_rules | A json array containing routing rules describing redirect behavior and when redirects are applied | `string` | `""` | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| versioning\_enabled | When set to 'true' the s3 origin bucket will have versioning enabled | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_bucket | n/a |
| s3\_bucket\_logging | n/a |

