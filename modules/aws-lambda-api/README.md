# terraform-aws-lambda-api

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| filename | File path to lambda deployment artifact | `` | no |
| handler | Lambda request handler | - | yes |
| http_method | HTTP method for trigger API gateway | - | yes |
| lambda_env_var | Environment variables for lambda function | `<map>` | no |
| name | Name of your Lambda API gateway | - | yes |
| region | The AWS region, e.g., us-west-2 | - | yes |
| role | Role for lambda function | - | yes |
| runtime | Lambda runtime | `python2.7` | no |
| timeout | Lambda function timeout | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the API gateway REST API |
| name | Name of the Lambda function |
