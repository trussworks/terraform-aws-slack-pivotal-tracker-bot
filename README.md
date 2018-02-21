# slack-pivotal-tracker-bot AWS module

This is the Terraform module for deploying slack-pivotal-tracker-bot to AWS Lambda

Please refer to the [application code repo](https://github.com/trussworks/slack-pivotal-tracker-bot) for more information on usage.

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| pivotal_token | API Token for accessing pivotal projects | - | yes |
| region | AWS region | `us-west-2` | no |
| slack_token | API token for posting Slack messages | - | yes |
| stage_name | Stage name of API deployment, e.g. production | `production` | no |

## Outputs

| Name | Description |
|------|-------------|
| slack_webhook_url |  |

## Installation

Installation is accomplished in four parts:

1. Generate Pivotal Tracker API token
1. Create a Slack slash command
1. Deploy Terraform module with API tokens
1. Update slash command with output URL

### Generate Pivotal Tracker API token

slack-pivotal-tracker-bot will use this API token to authenticate with Pivotal Tracker, allowing it to edit whatever projects that user has access to. We recommend you create a user specifically for this slack bot so you can better control that user's permissions.

- While logged in, visit your [Pivotal Tracker profile](https://www.pivotaltracker.com/profile) and scroll down to `API Token`
- Click `Create New Token`, and save it for step 3

### Create a Slack slash command

Next, you will create a slash command in Slack, which allows users to enter commands that are sent to a webhook URL:

- Navigate to your server's custom integrations page: `https://YOUR-SERVER.slack.com/apps/manage/custom-integrations`
- Go to your slash commands application and click on "Add Configuration"
- Add your preferred command (e.g. `/pivotal`), and click add
- Scroll down to integration settings and enter these settings:
  - Command: Should already be filled
  - URL(s): Leave blank for now
  - Method: POST
  - Token: This comes pre-filled, but save it for step 3
  - Customize Name: Name it whatever you'd like!
  - Customize Icon: Up to you
  - Autocomplete help text: Enter some text that you think will help the user
  - Translate User IDs: Leave checked
- Save integration

### Deploy Terraform module with API tokens

With your API tokens in hand, deploy the module as shown below:

```terraform
module "pivotal_tracker_bot" {
  source  = "trussworks/pivotal-tracker-bot/slack"
  version = "0.0.1"

  pivotal_token = "${var.pivotal_token}"
  slack_token   = "${var.slack_token}"
  region        = "${var.region}"
  stage_name    = "prod"
}
```

### Update Slack slash command with output URL

If you set up the Terraform module as above, the webhook URL should be output by Terraform after deployment. Head back to the slash command configuration page as before, but instead of creating a new command you can edit the command you made previously. Paste the webhook URL into the URL(s) field, hit save, and you're good to go!
