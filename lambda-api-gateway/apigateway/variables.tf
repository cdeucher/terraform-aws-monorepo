variable "lambda_adduser_invokearn" {
  type = string
  description = "The ARN of the Lambda function that will be invoked to add a user to the table"
}
variable "adduser_function_name" {
  description = "The name of the Lambda function that will be invoked to add a user to the table"
}
variable "region" {
  description = "AWS region"
}
variable "accountId" {
  description = "AWS account ID"
}