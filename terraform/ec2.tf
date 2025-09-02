# EC2 instance configuration
resource "aws_instance" "tf_server" {
  ami                         = var.ami_id # change according to region
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id] # associate security group
  associate_public_ip_address = true
  key_name                    = var.key_name # private aws key name
  user_data                   = <<-EOF
                                #!/bin/bash

                                # Git clone 
                                git clone https://github.com/edwarddume55/Node.js-App-with-MySQL-Automated-with-Terraform-on-AWS-.git /home/ubuntu/nodejs-mysql
                                cd /home/ubuntu/nodejs-mysql

                                # install nodejs
                                sudo apt update -y
                                sudo apt install -y nodejs npm

                                # edit env vars
                                echo "DB_HOST=${local.rds_endpoint}" | sudo tee .env
                                echo "DB_USER=${aws_db_instance.tf_rds_instance.username}" | sudo tee -a .env
                                sudo echo "DB_PASS=${aws_db_instance.tf_rds_instance.password}" | sudo tee -a .env
                                echo "DB_NAME=${aws_db_instance.tf_rds_instance.db_name}" | sudo tee -a .env
                                echo "TABLE_NAME=users" | sudo tee -a .env
                                echo "PORT=3000" | sudo tee -a .env

                                # start server
                                npm install
                                # Start app in background
                            nohup npm start > app.log 2>&1 &
                                EOF
  depends_on                  = [aws_s3_bucket.s3_bucket] # attach s3 bucket

  tags = {
    Name = "nodejsweb-server"
  }
}

# Security group for EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = var.vpc_id # default VPC

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks # allow from all IPs
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TCP"
    from_port   = var.app_port # for nodejs app
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr_blocks
  }
}

# output
output "ec2_public_ip" {
  value = aws_instance.tf_server.public_ip
}