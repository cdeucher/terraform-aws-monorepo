output "lambda_adduser_invokearn" {
  value = aws_lambda_function.adduser.invoke_arn
}
output "adduser_function_name" {
  value = aws_lambda_function.adduser.function_name
}