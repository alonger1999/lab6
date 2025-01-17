terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "korben-lab6"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "korben-lab6-lockid"
  }
}

# Configure the AWS provider
provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "web_app" {
  name        = "web_app"
  description = "security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_app"
  }
}

resource "aws_instance" "webapp_instance" {
  ami                    = "ami-0030bb9626529d09d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_app.id]

  tags = {
    Name = "webapp_instance"
  }
}

output "instance_public_ip" {
  value     = aws_instance.webapp_instance.public_ip
  sensitive = true
}
