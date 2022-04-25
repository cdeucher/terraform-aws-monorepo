variable "profile" {
  description = "AWS IAM Profile"
  default = "terraform_iam_user"
}
variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}
variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}