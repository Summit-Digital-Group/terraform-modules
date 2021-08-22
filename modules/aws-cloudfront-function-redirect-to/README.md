# Usage

<!--- BEGIN_TF_DOCS --->
# aws-cloudfront-function-redirect-to

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_function) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_static.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags to apply to all resources being generated | `map` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Default lambda name after the prexi. | `string` | `""` | no |
| <a name="input_path"></a> [path](#input\_path) | Has to match this path to be redirected to target | `string` | `"/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources being generated | `map` | `{}` | no |
| <a name="input_target"></a> [target](#input\_target) | The full url to redirect to on path match. Example: https://www.example.com | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_event_type"></a> [event\_type](#output\_event\_type) | n/a |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | n/a |
| <a name="output_include_body"></a> [include\_body](#output\_include\_body) | n/a |

<!--- END_TF_DOCS --->

