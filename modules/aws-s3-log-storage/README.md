# aws-s3-log-storage

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| abort\_incomplete\_multipart\_upload\_days | Maximum time (in days) that you want to allow multipart uploads to remain in progress | `number` | `5` | no |
| access\_log\_bucket\_name | Name of the S3 bucket where s3 access log will be sent to | `string` | `""` | no |
| acl | The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services | `string` | `"log-delivery-write"` | no |
| aliases | The websites being hosted out of this s3 bucket | `list` | <pre>[<br>  "demo.example.com",<br>  "demo-2.example.com"<br>]</pre> | no |
| block\_public\_acls | Set to `false` to disable the blocking of new public access lists on the bucket | `bool` | `true` | no |
| block\_public\_policy | Set to `false` to disable the blocking of new public policies on the bucket | `bool` | `true` | no |
| bucket\_name | The Amazon S3 bucket to serve as the origin for this cdn. | `string` | `""` | no |
| default\_root\_object | Object that CloudFront return when requests the root URL | `string` | `"index.html"` | no |
| default\_tags | Tags to apply to all resources being generated | `map` | <pre>{<br>  "private": true<br>}</pre> | no |
| enable\_glacier\_transition | Enables the transition to AWS Glacier which can cause unnecessary costs for huge amount of small files | `bool` | `true` | no |
| expiration\_days | Number of days after which to expunge the objects | `number` | `90` | no |
| force\_destroy | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| ignore\_public\_acls | Set to `false` to disable the ignoring of public access lists on the bucket | `bool` | `true` | no |
| kms\_master\_key\_arn | The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms | `string` | `""` | no |
| lifecycle\_prefix | Prefix filter. Used to manage object lifecycle events | `string` | `""` | no |
| lifecycle\_rule\_enabled | Enable lifecycle events on this bucket | `bool` | `true` | no |
| lifecycle\_tags | Tags filter. Used to manage object lifecycle events | `map(string)` | `{}` | no |
| logging | The Amazon S3 bucket to save logs into | `map` | <pre>{<br>  "bucket_name": "",<br>  "include_cookies": false,<br>  "prefix": ""<br>}</pre> | no |
| noncurrent\_version\_expiration\_days | Specifies when noncurrent object versions expire | `number` | `90` | no |
| noncurrent\_version\_transition\_days | Specifies when noncurrent object versions transitions | `number` | `30` | no |
| policy | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy | `string` | `""` | no |
| restrict\_public\_buckets | Set to `false` to disable the restricting of making the bucket public | `bool` | `true` | no |
| sse\_algorithm | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms | `string` | `"AES256"` | no |
| standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| versioning\_enabled | A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | n/a |

