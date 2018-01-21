output "slack_webhook_url" {
  value = "https://${module.slack_pivotal_tracker_bot.id}.execute-api.${var.region}.amazonaws.com/${terraform.env}/${module.slack_pivotal_tracker_bot.name}"
}
