<!--- BEGIN_TF_DOCS --->
# aws-lambda-edge-basic-auth

Lambda for basic authentication

Features:
- Lambda@Edge
- IAM
    - All accounts created with least privileges

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [archive_file.lambda_function](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags to apply to all resources being generated | `map` | `{}` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Default lambda name after the prexi. | `string` | `"basic-auth"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to be used when creating the lambda and iam roles associated with it. Defaults to random pet name. | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | The password to use when authenticating. If left blank a password will be generated automatically. | `string` | `""` | no |
| <a name="input_realm"></a> [realm](#input\_realm) | The name of the realm to associate with this auth lambda | `string` | `"Realm"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Number of days to retain lambda logs in cloudwatch | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources being generated | `map` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | The name to use when authenticating | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_event_type"></a> [event\_type](#output\_event\_type) | n/a |
| <a name="output_include_body"></a> [include\_body](#output\_include\_body) | n/a |
| <a name="output_lambda"></a> [lambda](#output\_lambda) | n/a |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |

<!--- END_TF_DOCS --->
