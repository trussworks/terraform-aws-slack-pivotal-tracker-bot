variable "name" {
  type        = "string"
  description = "Name of your Lambda API gateway"
}

variable "region" {
  type        = "string"
  description = "The AWS region, e.g., us-west-2"
}

variable "role" {
  type        = "string"
  description = "Role for lambda function"
}

variable "http_method" {
  type        = "string"
  description = "HTTP method for trigger API gateway"
}

variable "handler" {
  type        = "string"
  description = "Lambda request handler"
}

variable "runtime" {
  type        = "string"
  default     = "python2.7"
  description = "Lambda runtime"
}

variable "timeout" {
  type        = "string"
  default     = "3"
  description = "Lambda function timeout"
}

variable "s3_bucket" {
  type        = "string"
  description = "S3 bucket object containing lambda source code"
}

variable "s3_key" {
  type        = "string"
  description = "S3 bucket object containing lambda source code"
}

variable "lambda_env_var" {
  type        = "map"
  default     = {}
  description = "Environment variables for lambda function"
}
