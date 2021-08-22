## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| duration | The total time to keep the resource users cache. | `string` | `"31536000"` | no |
| function\_name | The name of the function. Defaults to cache-control-date | `string` | `""` | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| event\_type | n/a |
| function\_arn | n/a |
| include\_body | n/a |
