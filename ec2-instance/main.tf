resource "aws_instance" "my-app-example-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.my-app-example-1.id]

  user_data = <<-EOF
            #!/bin/bash
            sudo yum -y update
            sudo yum -y install httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "Proyecto Final!" > /var/www/html/my-endpoint.html
            EOF

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "my-app-example-1" {
  name        = var.instance_name
  description = "Allow API Access"
  vpc_id      = var.vpc_id

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
