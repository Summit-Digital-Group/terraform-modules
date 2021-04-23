# aws-cloudfront-s3-cdn

This module will configure a cloudfront endpoint being served from s3 using best practices and common configurations.

Features:
- Logging
    - Saved to encrypted S3
    - Automatic archival and purging of log files
- Lambda@theEdge Compatible
- IAM
    - All accounts created with least privileges

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aliases | The websites being hosted out of this s3 bucket | `list` | <pre>[<br>  "demo.example.com",<br>  "demo-2.example.com"<br>]</pre> | no |
| bucket\_name | The Amazon S3 bucket to serve as the origin for this cdn. | `string` | `""` | no |
| default\_cache | n/a | `map` | <pre>{<br>  "allowed_methods": [<br>    "DELETE",<br>    "GET",<br>    "HEAD",<br>    "OPTIONS",<br>    "PATCH",<br>    "POST",<br>    "PUT"<br>  ],<br>  "cached_methods": [<br>    "GET",<br>    "HEAD"<br>  ],<br>  "default_ttl": 3600,<br>  "forwarded_values": [<br>    {<br>      "cookies": [<br>        {<br>          "forward": "none"<br>        }<br>      ],<br>      "query_string": false<br>    }<br>  ],<br>  "max_ttl": 86400,<br>  "min_ttl": 0,<br>  "viewer_protocol_policy": "allow-all"<br>}</pre> | no |
| default\_tags | Tags to apply to all resources being generated | `map` | <pre>{<br>  "private": true<br>}</pre> | no |
| geo\_restriction\_locations | List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | `list(string)` | `[]` | no |
| geo\_restriction\_type | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | `string` | `"none"` | no |
| logging | The Amazon S3 bucket to save logs into | `map` | <pre>{<br>  "bucket_name": "",<br>  "include_cookies": false,<br>  "prefix": ""<br>}</pre> | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_bucket | n/a |
| s3\_bucket\_logging | n/a |

