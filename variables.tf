variable "region" {
  description = "AWS region"
  type        = "string"
  default     = "us-west-2"
}

variable "pivotal_token" {
  description = "API Token for accessing pivotal projects"
}

variable "slack_token" {
  description = "API token for posting Slack messages"
}

variable "stage_name" {
  description = "Stage name of API deployment, e.g. production"
  default     = "production"
}
