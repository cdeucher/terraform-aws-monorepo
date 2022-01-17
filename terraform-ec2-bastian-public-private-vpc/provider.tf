terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
/*   backend "s3" {
    bucket         = "my-tf-state"
    dynamodb_table = "my-inf-tflock"
    key            = "my-inf.tfstate"
    region         = "us-east-1"
  }  
 */}
provider "aws" {  
  region     = var.region
  profile    = var.profile
}