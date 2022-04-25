variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}
variable "vpc_id" { }
variable "security_group_id" {}


