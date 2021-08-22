## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| function\_name | Default lambda name after the prexi. | `string` | `""` | no |
| path | Has to match this path to be redirected to target | `string` | `"/"` | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| target | The full url to redirect to on path match. Example: https://www.example.com | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| event\_type | n/a |
| function\_arn | n/a |
| include\_body | n/a |
