## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assign\_public\_ip | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default true. | `bool` | `true` | no |
| aws\_ecs\_cluster\_name | The ecs cluster to associate this ecs-service with | `any` | n/a | yes |
| awslogs\_group | The name of the logs group to send log event to. | `any` | n/a | yes |
| awslogs\_prefix | The prefix to use when sending log events to the logs group. | `any` | n/a | yes |
| container\_count | Number of instances of the task definition to place and keep running. | `number` | `3` | no |
| container\_image | The url location of the container image to use | `any` | n/a | yes |
| container\_name | The name you want to use to describe the container | `any` | n/a | yes |
| container\_port | The port to map incoming traffic to on the container | `any` | n/a | yes |
| cpu | The total amount of cpu resources available to this container | `number` | `256` | no |
| deployment\_maximum\_percent | Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. | `number` | `100` | no |
| deployment\_minimum\_healthy\_percent | Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `10` | no |
| ecs\_cluster\_id | The cluster to add this service to. | `any` | n/a | yes |
| environment\_vars | n/a | `list` | <pre>[<br>  {<br>    "name": "NODE_ENV",<br>    "value": "production"<br>  },<br>  {<br>    "name": "NO_COLOR",<br>    "value": "true"<br>  }<br>]</pre> | no |
| force\_new\_deployment | Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination | `bool` | `false` | no |
| host\_port | The port to map incoming traffic to on the ecs host | `any` | `null` | no |
| ingress\_security\_group | AWS ALB security group to use with ecs service network  configuration | `any` | n/a | yes |
| launch\_type | Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. | `string` | `"FARGATE"` | no |
| memory | The total amount of memory resources available to this container | `number` | `512` | no |
| name\_prefix | Default prefix to use when creating resources. If none provided use container name. | `string` | `""` | no |
| network\_mode | Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host. | `string` | `"awsvpc"` | no |
| region | The aws region to create the resources in. | `string` | `"us-east-1"` | no |
| requires\_compatibilities | Set of launch types required by the task. The valid values are EC2 and FARGATE. | `list` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| secrets | n/a | `list` | `[]` | no |
| subnets | The subnets to use for the alb traffic and security group config | `any` | n/a | yes |
| tags | n/a | `map` | `{}` | no |
| target\_group\_arn | The target | `any` | n/a | yes |
| vpc\_id | The vpc id to associate with network resources. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_service | n/a |
| ecs\_service\_name | n/a |
| ecs\_task\_definition | n/a |
| security\_group | n/a |
