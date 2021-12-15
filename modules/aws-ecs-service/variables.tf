variable "ecs_cluster_id" {
  description = "The cluster to add this service to."
}

variable "container_port" {
  description = "The port to map incoming traffic to on the container"
}

variable "host_port" {
  description = "The port to map incoming traffic to on the ecs host"
  default     = null
}

variable "container_name" {
  description = "The name you want to use to describe the container"
}

variable "container_image" {
  description = "The url location of the container image to use"
}

variable "cpu" {
  description = "The total amount of cpu resources available to this container"
  default     = 256
}

variable "memory" {
  description = "The total amount of memory resources available to this container"
  default     = 512
}

variable "region" {
  description = "The aws region to create the resources in."
  default     = "us-east-1"
}

variable "awslogs_group" {
  description = "The name of the logs group to send log event to."
  default     = ""
}

variable "awslogs_prefix" {
  description = "The prefix to use when sending log events to the logs group."
  default     = ""
}

variable "aws_ecs_cluster_name" {
  description = "The ecs cluster to associate this ecs-service with"
}

variable "subnets" {
  description = "The subnets to use for the alb traffic and security group config"
}

variable "target_group_arn" {
  description = "The target"
}

variable "vpc_id" {
  description = "The vpc id to associate with network resources."
}

variable "name_prefix" {
  description = "Default prefix to use when creating resources. If none provided use container name."
  default     = ""
}

variable "ingress_security_group" {
  description = "AWS ALB security group to use with ecs service network  configuration"
}

variable "secrets" {
  default = []
}

variable "environment_vars" {
  default = [
    {
      name  = "NODE_ENV"
      value = "production"
    },
    { name  = "NO_COLOR"
      value = "true"
    }
  ]
}

variable "tags" {
  default = {}
}

variable "force_new_deployment" {
  description = "Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination"
  default     = false
}

variable "container_count" {
  description = "Number of instances of the task definition to place and keep running."
  default     = 3
}

variable "deployment_maximum_percent" {
  description = "Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
  default     = 100
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  default     = 10
}

variable "launch_type" {
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL."
  default     = "FARGATE"
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default true."
  default     = true
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE."
  default     = ["FARGATE"]
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  default     = "awsvpc"
}

variable "logging_enabled" {
  description = "This will enable awslogs. Docs: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
  default     = true
}

variable "readonly_root_filesystem" {
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value	"
  default     = true
}

variable "sidecar_enabled" {
  default = false
}

variable "container_sidecar_def" {
  //  type = object({
  //    container_name  = string
  //    container_image = string
  //    //    readonly_root_filesystem = string
  //    //    environment_vars = list(object({}))
  //    //    secrets          = list(object({name=string, valueFrom=string}))
  //    container_port = number
  //    host_port      = number
  //    //    logging_enabled          = bool
  //    //    awslogs_group            = string
  //    //    awslogs_prefix           = string
  //  })
  default = null
}

variable "load_balancer_container_name" {
  description = "When provided will override the default container_name"
  default     = ""
}

variable "load_balancer_container_port" {
  description = "When provided will override the default container_port"
  default     = ""
}

variable "enable_execute_command" {
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service."
  default     = false
}

variable "container_defs" {
  default = []
}

variable "use_passed_container" {
  default = false
}