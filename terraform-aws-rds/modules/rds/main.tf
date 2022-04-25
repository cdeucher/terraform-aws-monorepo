resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db subnet group"
  subnet_ids = var.subnet

  tags = {
    Name = "SubnetGroup"
  }
}
resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "db-parameter-group"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier             = "db-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "postgresql"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.security_group.id]
  parameter_group_name   = aws_db_parameter_group.db_parameter_group.name
  publicly_accessible    = false
  skip_final_snapshot    = true
}
