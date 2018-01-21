// The ID of the API gateway REST API
output "id" {
  value = "${aws_api_gateway_rest_api.lambda_api.id}"
}

// Name of the Lambda function
output "name" {
  value = "${aws_lambda_function.lambda.function_name}"
}
