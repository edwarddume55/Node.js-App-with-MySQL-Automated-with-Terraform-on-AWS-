variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC ID for security groups"
  type        = string
  default     = "vpc-00603c3466a5fe3f0"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "terraform-ec2"
}

variable "rds_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "rds_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  default     = "AdminPass123!"
}

variable "rds_db_name" {
  description = "RDS database name"
  type        = string
  default     = "tf_dume_demo"
}

variable "s3_bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  default     = "my-tf-dynamicweb-bucket0012"
}

variable "app_port" {
  description = "Port for the Node.js application"
  type        = number
  default     = 3000
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the EC2 instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


