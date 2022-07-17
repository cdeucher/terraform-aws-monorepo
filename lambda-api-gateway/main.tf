module "dynamodb" {
  source = "./dynamodb"
  table_name = var.tabe_name
}

module "lambda" {
  source = "./lambda"
  tabe_name    = var.tabe_name
  dynamodb_arn = module.dynamodb.dymanodb_arn
}

module "apigateway" {
  source = "./apigateway"

  lambda_adduser_invokearn    = module.lambda.lambda_adduser_invokearn
  adduser_function_name       = module.lambda.adduser_function_name
  accountId                   = var.accountId
  region                      = var.region
}