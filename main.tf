provider "aws" {
region = "us-east-1"
access_key = "AKIA6JALO5LYHEQ266O4"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-06a0cd9728546d178"
  instance_type   = "t2.micro"
  key_name        = "Terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by rajiv server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-06a0cd9728546d178"
  instance_type   = "t2.micro"
  key_name        = "Terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by rajiv server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-06a0cd9728546d178"
  instance_type   = "t2.micro"
  key_name        = "Terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-06a0cd9728546d178"
  instance_type   = "t2.micro"
  key_name        = "Terraform"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  tags = {
       Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_user" "seven" {
name = "rajiv-IAM"
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "us-east-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
