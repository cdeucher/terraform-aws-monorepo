data "archive_file" "code" {
  type        = "zip"
  source_file = "./users/users.py"
  output_path = "outputs/users.zip"
}

resource "aws_lambda_function" "adduser" {
  function_name    = "api_adduser"
  role             = aws_iam_role.role_for_lambda.arn
  runtime          = "python3.8"
  filename         = data.archive_file.code.output_path
  handler          = "users.api_adduser"
  source_code_hash = data.archive_file.code.output_base64sha256
  publish          = true
  environment {
    variables = {
      USERS_TABLE = var.tabe_name
    }
  }
}
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${aws_lambda_function.adduser.function_name}"
  retention_in_days = 1
}