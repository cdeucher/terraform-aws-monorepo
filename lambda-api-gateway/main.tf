module "dynamodb" {
  source = "./dynamodb"
  table_name = var.tabe_name
  attributes = var.dynamodb_attributes
}

module "lambda" {
  source = "./lambda"
  tabe_name    = var.tabe_name
  dynamodb_arn = module.dynamodb.dymanodb_arn
}

module "apigateway" {
  source = "./apigateway"

  lambda_addtitle_invokearn    = module.lambda.lambda_addtitle_invokearn
  addtitle_function_name       = module.lambda.addtitle_function_name
  accountId                   = var.accountId
  region                      = var.region
}