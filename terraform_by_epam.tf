 provider  "aws" {
   access_key = "your_access_key"
   secret_key = "your_secret_key"
   region = "eu-central-1"
 }

 resource "aws_instance" "Test_RedHat" {
   count = 1
   ami = "ami-0badcc5b522737046"
   instance_type = "t2.micro"
   key_name = "test"
   vpc_security_group_ids = [aws_security_group.webserver.id]
   user_data = <<EOF
#!/bin/bash
sudo yum -y update
sudo reboot
EOF
     tags = {
     Name = "Test_RedHat"
     Env  = "Test"
   }
 }

 resource "aws_instance" "Test_Ubuntu" {
   count = 1
   ami = "ami-050a22b7e0cf85dd0"
   instance_type = "t2.micro"
   key_name = "test"
   vpc_security_group_ids = [aws_security_group.webserver.id]
   user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt install -y aptitude
sudo reboot
EOF
     tags = {
     Name = "Test_Ubuntu"
     Env  = "Test"
    }
  }

 resource "aws_instance" "RedHat" {
   count = 1
   ami = "ami-0badcc5b522737046"
   instance_type = "t2.micro"
   key_name = "prod"
   vpc_security_group_ids = [aws_security_group.webserver.id]
   user_data = <<EOF
#!/bin/bash
sudo yum -y update
sudo reboot
EOF
      tags = {
      Name = "Prod_RedHat"
      Env  = "Prod"
    }
  }

  resource "aws_instance" "Ubuntu" {
    count = 1
    ami = "ami-050a22b7e0cf85dd0"
    instance_type = "t2.micro"
    key_name = "prod"
    vpc_security_group_ids = [aws_security_group.webserver.id]
    user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt install -y aptitude
sudo reboot
EOF
      tags = {
      Name = "Prod_Ubuntu"
      Env  = "Prod"
     }
   }

  resource "aws_key_pair" "test" {
        public_key = "your_public_key"
  }

  resource "aws_key_pair" "prod" {
         public_key = "your_public_key"

  }
  resource "aws_security_group" "webserver" {
    name        = "My_webserver_test"
    description = "My_webserver_test"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }
  }
