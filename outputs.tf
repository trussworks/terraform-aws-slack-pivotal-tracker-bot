output "slack_webhook_url" {
  value = "https://${module.slack_pivotal_tracker_bot.id}.execute-api.${var.region}.amazonaws.com/${var.stage_name}/${module.slack_pivotal_tracker_bot.name}"
}
