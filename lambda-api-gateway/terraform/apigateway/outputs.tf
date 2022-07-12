output "main_url" {
  value = "${aws_api_gateway_rest_api.api.id}/${aws_api_gateway_deployment.main.stage_name}/_user_request_"
}
