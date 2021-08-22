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
| availability\_zones | n/a | `list` | <pre>[<br>  ""<br>]</pre> | no |
| backup\_retention\_period | n/a | `number` | `4` | no |
| cluster\_identifier | n/a | `string` | n/a | yes |
| database\_name | The default database to be created when provisioning the RDS cluster. | `string` | `"postgres"` | no |
| instance\_class | The instance class to use. For details on CPU and memory. See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html | `string` | `"db.m5.large"` | no |
| instances | The total number of instances that are provisioned with this cluster. | `number` | `2` | no |
| monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Docs: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html | `any` | `null` | no |
| password | The password to use for the root account. Defaults to a randomly generated password. | `string` | `""` | no |
| performance\_insights\_enabled | Specifies whether Performance Insights is enabled or not. | `bool` | `true` | no |
| performance\_insights\_kms\_key\_id | The ARN for the KMS key to encrypt Performance Insights data. When specifying performance\_insights\_kms\_key\_id, performance\_insights\_enabled needs to be set to true. | `any` | `null` | no |
| preferred\_backup\_window | n/a | `string` | `"07:00-09:00"` | no |
| publicly\_accessible | If set to true will allow external traffic to be able to access these instances. See the documentation on Creating DB Instances for more details on controlling this property. https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html | `bool` | `false` | no |
| storage\_encrypted | Specifies whether the DB cluster is encrypted. | `bool` | `true` | no |
| tags | n/a | `map` | `{}` | no |
| username | The username to use for the root account. | `string` | `"postgres"` | no |
| vpc\_cidrs | List of cidr blocks to allow traffic to originate from. | `list(any)` | n/a | yes |
| vpc\_id | The ID of the VPC to create the RDS resources within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster | n/a |
| instances | n/a |
| password | n/a |
| security\_group | n/a |
| username | n/a |
