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
| archive | n/a |
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| lambda\_name | Default lambda name after the prexi. | `string` | `"edge-cache-header"` | no |
| max\_age | The maximum age to keep content locally cached with the cache-control header. Should be in ms | `string` | `"31536000"` | no |
| name\_prefix | Prefix to be used when creating the lambda and iam roles associated with it. Defaults to random pet name. | `string` | `""` | no |
| retention\_in\_days | Number of days to retain lambda logs in cloudwatch | `number` | `30` | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| event\_type | n/a |
| include\_body | n/a |
| lambda | n/a |
| lambda\_arn | n/a |
| name | n/a |
| qualified\_arn | n/a |

