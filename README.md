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
1. Create a Slack outgoing webhook
1. Deploy Terraform module with API tokens
1. Update Slack webhook with output URL

### Generate Pivotal Tracker API token

slack-pivotal-tracker-bot will use this API token to authenticate with Pivotal Tracker, allowing it to edit whatever projects that user has access to. We recommend you create a user specifically for this slack bot so you can better control that user's permissions.

- While logged in, visit your [Pivotal Tracker profile](https://www.pivotaltracker.com/profile) and scroll down to `API Token`
- Click `Create New Token`, and save it for step 3

### Create a Slack outgoing webhook

Next, you will create an outgoing webhook in Slack, which tells Slack to listen for your preferred keyphrase and send that message to the provided URL:

- Navigate to your server's custom integrations page: `https://YOUR-SERVER.slack.com/apps/manage/custom-integrations`
- Go to your outgoing webhook application and click on "Add Configuration", and click through the next screen
- Scroll down to integration settings and enter these settings:
  - Channel: Any
  - Trigger Word(s): Use something unique and easy to remember, e.g. `!pivotal`
  - URL(s): Leave blank for now
  - Token: This comes pre-filled, but save it for step 3
  - Descriptive Label: Anything (optional)
  - Customize Name: Name it whatever you'd like!
  - Customize Icon: Up to you
  - Translate User IDs: Leave checked
- Save webhook

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

### Update Slack webhook with output URL

If you set up the Terraform module as above, the webhook URL should be output by Terraform after deployment. Head back to the outgoing webhook page as before, but instead of creating a new webook you can edit the webhook you made previously. Paste the output webhook URL into the URL(s) field, hit save, and you're good to go!
