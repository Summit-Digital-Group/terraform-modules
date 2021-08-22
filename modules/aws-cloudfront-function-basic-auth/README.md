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
| password | The password to use when authenticating. If left blank a password will be generated automatically. | `string` | `""` | no |
| realm | The name of the realm to associate with this auth lambda | `string` | `"Realm"` | no |
| tags | Tags to apply to all resources being generated | `map` | `{}` | no |
| username | The name to use when authenticating | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| event\_type | n/a |
| function\_arn | n/a |
| include\_body | n/a |
| password | n/a |
| username | n/a |
