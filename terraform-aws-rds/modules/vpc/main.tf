
resource "aws_vpc" "main" {
  cidr_block           = var.CIDR 
  enable_dns_hostnames = true

  //nat_gateway_enabled  = false
  //nat_instance_enabled = false
}



