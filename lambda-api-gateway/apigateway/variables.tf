variable "lambda_addtitle_invokearn" {
  type = string
  description = "The ARN of the Lambda function that will be invoked to add a titles to the table"
}
variable "addtitle_function_name" {
  description = "The name of the Lambda function that will be invoked to add a titles to the table"
}
variable "region" {
  description = "AWS region"
}
variable "accountId" {
  description = "AWS account ID"
}