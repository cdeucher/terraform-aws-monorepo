variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}
variable "vpc" {
  default = ""
  description = ""
}
variable "subnet" {
  default = ""
  description = ""
}
variable "security_group" {
  default = ""
  description = ""
}