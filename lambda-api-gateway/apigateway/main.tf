resource "aws_api_gateway_rest_api" "api" {
  name = "api"
}

resource "aws_api_gateway_resource" "titles" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "titles"
}

resource "aws_api_gateway_method" "addtitle" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.titles.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "addtitle" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.titles.id
  http_method             = aws_api_gateway_method.addtitle.http_method
  type                    = "AWS_PROXY"
  uri                     = var.lambda_addtitle_invokearn
  integration_http_method = "POST"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.addtitle_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn    = local.addtitle
}
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "main"
  depends_on = [
    aws_api_gateway_method.addtitle,
    aws_api_gateway_integration.addtitle,
  ]
}
