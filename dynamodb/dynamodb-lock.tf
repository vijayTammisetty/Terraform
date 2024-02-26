provider "aws" {
  
}

resource "aws_vpc" "cVPc" {
  cidr_block = "10.0.0.0/16"
  
}
resource "aws_subnet" "mysub" {
  vpc_id = aws_vpc.cVPc.id
  cidr_block = "10.0.0.0/25"
  
}
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.cVPc.id
  
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.cVPc.id
  route {
    gateway_id = aws_internet_gateway.IG.id
    cidr_block = "0.0.0.0/0"
  }
  
}

resource "aws_route_table_association" "RTA" {
  subnet_id = aws_subnet.mysub.id
  route_table_id = aws_route_table.RT.id
  
}

resource "aws_instance" "Myec2" {
  ami = "ami-0440d3b780d96b29d"
  key_name = "dynamo"
  instance_type = "t2.micro"
  tags ={
    Name = "NewEC2"
  }
  subnet_id = aws_subnet.mysub.id
  
  
}