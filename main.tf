provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-0bef6cc322bfff646"
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
