/*
 * SimpleDB
 */

resource "aws_simpledb_domain" "sdb_domain" {
  name = "slack-pivotal-tracker-bot-${var.stage_name}"
}

/*
 * IAM
 */

data "aws_iam_policy_document" "lambda_trust_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role_for_lambda" {
  name               = "iam-role-for-slack-pivotal-tracker-bot-${var.stage_name}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_trust_document.json}"
}

data "aws_iam_policy_document" "lambda_role_policy_document" {
  statement {
    actions = [
      "sdb:GetAttributes",
      "sdb:PutAttributes",
      "sdb:DeleteAttributes",
      "sdb:Select",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:sdb:*:*:domain/${aws_simpledb_domain.sdb_domain.id}",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*:*",
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "iam-policy-for-slack-pivotal-tracker-bot-${var.stage_name}"
  policy = "${data.aws_iam_policy_document.lambda_role_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.iam_role_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

/*
 * Lambda + API Gateway
 */

module "slack_pivotal_tracker_bot" {
  source      = "modules/aws-lambda-api"
  name        = "slack-pivotal-tracker-bot-${var.stage_name}"
  role        = "${aws_iam_role.iam_role_for_lambda.arn}"
  region      = "${var.region}"
  http_method = "POST"
  handler     = "handler.lambda_handler"
  runtime     = "python3.6"
  timeout     = "10"
  s3_bucket   = "slack-pivotal-tracker-bot"
  s3_key      = "releases/slack-pivotal-tracker-bot-v1.0.0.zip"

  lambda_env_var = {
    slack_token   = "${var.slack_token}"
    pivotal_token = "${var.pivotal_token}"
    sdb_domain    = "${aws_simpledb_domain.sdb_domain.id}"
  }
}

resource "aws_api_gateway_deployment" "slack_pivotal_tracker_bot_api_deployment" {
  depends_on  = ["module.slack_pivotal_tracker_bot"]
  rest_api_id = "${module.slack_pivotal_tracker_bot.id}"
  description = "Deploy methods: POST"
  stage_name  = "${var.stage_name}"
}
