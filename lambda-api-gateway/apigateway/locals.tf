locals {
  adduser = "arn:aws:execute-api:${var.region}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.adduser.http_method}${aws_api_gateway_resource.users.path}"
}