<!--- BEGIN_TF_DOCS --->
# ecs-service

Provides an ECS service - effectively a task that is expected to run until an error occurs or a user terminates it (typically a webserver or a database).

This resource is designed to work optimally with fargate service tasks out of the box.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container_sidecar_defs"></a> [container\_sidecar\_defs](#module\_container\_sidecar\_defs) | cloudposse/ecs-container-definition/aws | n/a |
| <a name="module_this_container_def"></a> [this\_container\_def](#module\_this\_container\_def) | cloudposse/ecs-container-definition/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default true. | `bool` | `true` | no |
| <a name="input_aws_ecs_cluster_name"></a> [aws\_ecs\_cluster\_name](#input\_aws\_ecs\_cluster\_name) | The ecs cluster to associate this ecs-service with | `any` | n/a | yes |
| <a name="input_awslogs_group"></a> [awslogs\_group](#input\_awslogs\_group) | The name of the logs group to send log event to. | `string` | `""` | no |
| <a name="input_awslogs_prefix"></a> [awslogs\_prefix](#input\_awslogs\_prefix) | The prefix to use when sending log events to the logs group. | `string` | `""` | no |
| <a name="input_container_count"></a> [container\_count](#input\_container\_count) | Number of instances of the task definition to place and keep running. | `number` | `3` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The url location of the container image to use | `any` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name you want to use to describe the container | `any` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port to map incoming traffic to on the container | `any` | n/a | yes |
| <a name="input_container_sidecar_def"></a> [container\_sidecar\_def](#input\_container\_sidecar\_def) | n/a | `any` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The total amount of cpu resources available to this container | `number` | `256` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. | `number` | `100` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `10` | no |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | The cluster to add this service to. | `any` | n/a | yes |
| <a name="input_environment_vars"></a> [environment\_vars](#input\_environment\_vars) | n/a | `list` | <pre>[<br>  {<br>    "name": "NODE_ENV",<br>    "value": "production"<br>  },<br>  {<br>    "name": "NO_COLOR",<br>    "value": "true"<br>  }<br>]</pre> | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination | `bool` | `false` | no |
| <a name="input_host_port"></a> [host\_port](#input\_host\_port) | The port to map incoming traffic to on the ecs host | `any` | `null` | no |
| <a name="input_ingress_security_group"></a> [ingress\_security\_group](#input\_ingress\_security\_group) | AWS ALB security group to use with ecs service network  configuration | `any` | n/a | yes |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. | `string` | `"FARGATE"` | no |
| <a name="input_load_balancer_container_name"></a> [load\_balancer\_container\_name](#input\_load\_balancer\_container\_name) | When provided will override the default container\_name | `string` | `""` | no |
| <a name="input_load_balancer_container_port"></a> [load\_balancer\_container\_port](#input\_load\_balancer\_container\_port) | When provided will override the default container\_port | `string` | `""` | no |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | This will enable awslogs. Docs: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | `bool` | `true` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The total amount of memory resources available to this container | `number` | `512` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Default prefix to use when creating resources. If none provided use container name. | `string` | `""` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host. | `string` | `"awsvpc"` | no |
| <a name="input_readonly_root_filesystem"></a> [readonly\_root\_filesystem](#input\_readonly\_root\_filesystem) | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | The aws region to create the resources in. | `string` | `"us-east-1"` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | Set of launch types required by the task. The valid values are EC2 and FARGATE. | `list` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | `list` | `[]` | no |
| <a name="input_sidecar_enabled"></a> [sidecar\_enabled](#input\_sidecar\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The subnets to use for the alb traffic and security group config | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The target | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc id to associate with network resources. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service"></a> [ecs\_service](#output\_ecs\_service) | n/a |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | n/a |
| <a name="output_ecs_task_definition"></a> [ecs\_task\_definition](#output\_ecs\_task\_definition) | n/a |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |

<!--- END_TF_DOCS --->
