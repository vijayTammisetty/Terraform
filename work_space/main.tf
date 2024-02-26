provider "aws" {
  
}

#resource "aws_vpc" "nvpc" {
 #   cidr_block = "10.0.0.0/16"
  #  tags = {
   #   Name = "Custom"
    #}
  
#}


resource "aws_s3_bucket" "ns3" {
    bucket = "vi-s3-01"

}

resource "aws_dynamodb_table" "db_table" {
    name = "terraform-state-lock-dynamo222"
    read_capacity = 20
    write_capacity = 20
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
  
}


