terraform {
  backend "s3" {
    bucket = "om-123"
    key = "terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "us-east-1"
    encrypt = true
  }
}