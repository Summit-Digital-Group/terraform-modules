# Terraform Modules
A set of opinionated terraform modules following best practices and common patters

## Getting Started

### Tools
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

## Modules

- aws-cloudfront-function-basic-auth              
- aws-lambda-edge-basic-auth
- aws-cloudfront-function-basic-auth-to-redirect  
- aws-lambda-edge-cache-header
- aws-cloudfront-function-redirect-to             
- aws-rds-postgres-cluster
- aws-cloudfront-response-cache-header            
- aws-s3-log-storage
- aws-cloudfront-s3-cdn                           
- ecs-service
- aws-ecs-service



## Generating Readmes

```shell
terraform-docs markdown -c ./.tfdocs-config.yml ./ > README.md
```
