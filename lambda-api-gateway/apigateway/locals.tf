locals {
  addtitle = "arn:aws:execute-api:${var.region}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.addtitle.http_method}${aws_api_gateway_resource.titles.path}"
}