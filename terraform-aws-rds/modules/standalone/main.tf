data "aws_vpc" "selected" {
  id = var.vpc_id.id
}

data "aws_subnet_ids" "subnet" {
  vpc_id = data.aws_vpc.selected.id
/*   filter {
    name   = "tag:Name"
    values = [var.private_subnet_name]
  }  */ 
}

data "aws_security_group" "selected" {
  id = var.security_group_id
}

module "rds" {
  source         = "../rds"
  db_password    = var.db_password
  vpc            = data.aws_vpc.selected
  subnet         = data.aws_subnet_ids.subnet.ids
  security_group = data.aws_security_group.selected
} 