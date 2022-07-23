output "main_url" {
  value = "${aws_api_gateway_rest_api.api.id}/${aws_api_gateway_deployment.main.stage_name}/_titles_request_"
}
output "invoke_url" {
  value = aws_api_gateway_deployment.main.invoke_url
}
output "local_addtitle_url" {
  value = local.addtitle
}
