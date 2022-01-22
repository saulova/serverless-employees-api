resource "aws_dynamodb_table" "this" {
  name         = local.namespaced_service_name
  hash_key     = "employeeId"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "employeeId"
    type = "N"
  }
}

resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
  "employeeId": {"N": "1"},
  "age": {"N": "20"},
  "name": {"N": "Fulano de Tal"},
  "occupation": {"S": "Desenvolvedor"}
}
ITEM
}
