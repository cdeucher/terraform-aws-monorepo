terraform {
  required_version = ">= 0.14.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
}

variable "pg_host" {
  description = "Endereço do servidor PostgreSQL"
  type        = string
}

variable "pg_port" {
  description = "Porta do servidor PostgreSQL"
  type        = number
}

variable "pg_user" {
  description = "Usuário do servidor PostgreSQL"
  type        = string
}

variable "pg_pass" {
  description = "Senha do servidor PostgresSQL"
  type        = string
}

variable "pg_dbname" {
  description = "Nome do banco de dados do servidor PostgreSQL"
  type        = string
}

module "iam" {
  source = "./terraform/iam"
}

module "lambda" {
  source = "./terraform/lambda"

  iam_role_arn = module.iam.iam_role_arn
  pg_host      = var.pg_host
  pg_port      = var.pg_port
  pg_user      = var.pg_user
  pg_pass      = var.pg_pass
  pg_dbname    = var.pg_dbname
}

module "apigateway" {
  source = "./terraform/apigateway"

  lambda_addtarefa_invokearn    = module.lambda.lambda_addtarefa_invokearn
  lambda_listtarefa_invokearn   = module.lambda.lambda_listtarefa_invokearn
  lambda_gettarefa_invokearn    = module.lambda.lambda_gettarefa_invokearn
  lambda_edittarefa_invokearn   = module.lambda.lambda_edittarefa_invokearn
  lambda_deletetarefa_invokearn = module.lambda.lambda_deletetarefa_invokearn
}

output "main_url" {
  description = "Endpoint do API Gateway"
  value       = module.apigateway.main_url
}