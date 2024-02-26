terraform {
  backend "s3" {
    bucket = "vijay-s3-01"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt = true
    
  }
}