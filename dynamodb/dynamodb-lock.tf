provider "aws" {
  
}

resource "aws_s3_bucket" "My_bucket" {
    bucket = "om-123"
  
}

resource "aws_dynamodb_table" "mydb-table" {
    name = "terraform-state-lock-dynamo"
    read_capacity = 20
    write_capacity = 20
    hash_key = "LockId"

    attribute {
      name = "LockId"
      type = "S"
    }
  
}