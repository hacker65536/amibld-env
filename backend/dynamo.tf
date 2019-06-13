resource "aws_dynamodb_table" "dynamo" {
  name = "${terraform.workspace}-state-locking"

  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

output "dynamodb_table" {
  value = aws_dynamodb_table.dynamo.id
}
