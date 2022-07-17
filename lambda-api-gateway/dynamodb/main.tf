resource "aws_dynamodb_table" "dbtable" {
  name             = var.table_name
  hash_key         = "userId"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  attribute {
    name = "userId"
    type = "S"
  }
}
