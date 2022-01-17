variable "subnet_public" {
  description = "subnet_public"
  default = ""
}
variable "subnet_private" {
  description = "subnet_private"
  default = ""
}
variable "security_group" {
  description = "security_group"
  default = ""
}
variable "aws_vpc" {
  description = "aws_vpc"
  default = ""
}
variable "key_name" {
  description = "Public key name"
  default = "newMyKeyPair"
  type = string
}
variable "ami" {
  description = "AMI"
  default = "ami-02fe94dee086c0c37"
  type = string
}
variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
  type = string
}
variable "spot_price" {
  description = "Price of spot instances"
  default = "0.03"
  type = string
}