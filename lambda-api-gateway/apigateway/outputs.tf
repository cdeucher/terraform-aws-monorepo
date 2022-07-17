output "main_url" {
  value = "${aws_api_gateway_rest_api.api.id}/${aws_api_gateway_deployment.main.stage_name}/_user_request_"
}
output "invoke_url" {
  value = aws_api_gateway_deployment.main.invoke_url
}
output "local_adduser_url" {
  value = local.adduser
}
