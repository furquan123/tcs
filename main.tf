provider "aws" {
region = "ap-south-1"
access_key = "AKIAWDHXRCZ44O436KI7"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-0d92749d46e71c34c"
  instance_type   = "t2.micro"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0d92749d46e71c34c"
  instance_type   = "t2.micro"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by raham sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-0d92749d46e71c34c"
  instance_type   = "t2.micro"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-0d92749d46e71c34c"
  instance_type   = "t2.micro"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-fk23"
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

resource "aws_s3_bucket" "six" {
  bucket = "fk23"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["lnmonpqrst", "hijk", "efg", "abcd"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "ap-south-1a"
  size = 25
  tags = {
    Name = "nice-01"
  }
}
