provider "aws" {
  
}

# Custom VPC
resource "aws_vpc" "CVPC" {
    cidr_block = "10.0.0.0/16"
  
}

# Internet gate Way
resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.CVPC.id
  
}

# Custome Subnet
resource "aws_subnet" "PSub" {
    vpc_id = aws_vpc.CVPC.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true

  
}

# Rout Table

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.CVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG.id
    }
  
}

resource "aws_route_table_association" "RTA" {
    subnet_id = aws_subnet.PSub.id
    route_table_id = aws_route_table.RT.id
}

# Public Key Pair
resource "aws_key_pair" "My-key" {
  key_name = "provisionar"
  public_key = file("C:/Users/vijaya kumar/.ssh/id_rsa.pub")
}

# security Groups
resource "aws_security_group" "sec_gp" {
  name = "MYSG"
  vpc_id = aws_vpc.CVPC.id

  ingress {
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "HHTP from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "HTTPS from VPC"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "My-instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.My-key.key_name
    subnet_id = aws_subnet.PSub.id
    security_groups = [aws_security_group.sec_gp.id]

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }

    # remote execution process
    provisioner "remote-exec" {
        inline = [
        "touch file200",
        "echo hello from aws >> file200",
        ]  
    } 

    # Local Execution Process
    provisioner "local-exec" {
        command = "touch file100"
      
    }
}






