terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "lab6_instance" {
  ami           = "ami-03c7d01cf4dedc891"
  instance_type = "t2.micro"
  key_name = "lab4key"
  security_groups = [aws_security_group.Lab6_SG.name]

  user_data = "${file("init.sh")}"

  tags = {
    Name = "Lab 6 Instance"
  }
}

resource "aws_security_group" "Lab6_SG" {
  name        = "Lab 6 Security Group"
  description = "Lab 6 Security Group"
  vpc_id      = "vpc-0d81fb0d0468f0b18"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Lab6_SG"
  }
}
