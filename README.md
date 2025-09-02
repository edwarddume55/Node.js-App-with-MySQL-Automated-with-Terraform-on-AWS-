# Node.js App with MySQL (Automated with Terraform on AWS)

This project demonstrates deploying a **Node.js + MySQL application** on **AWS Cloud** using **Terraform**.  

It provisions:  
- EC2 Instance → Runs Node.js app  
- RDS (MySQL) → Manages database  
- S3 Bucket → Storage integration  
- Security Groups → Secure networking  

---

## Deployment on AWS (with Terraform)

### Prerequisites
- AWS account with programmatic access (`aws configure`)
- Terraform ≥ 1.3.0
- An existing SSH key pair in AWS (e.g., `terraform-ec2`)
---
### Steps
1. **Clone this repo:**
   ```bash
   git clone https://github.com/edwarddume55/Node.js-App-with-MySQL-Automated-with-Terraform-on-AWS-.git
   cd nodejs-mysql/terraform

2. **Initialize Terraform:**
    ```bash
    terraform init


3. **Review the plan:**
    ```bash
    terraform plan


4. **Apply infrastructure:**
    ```bash
    terraform apply -auto-approve

---
## Get the EC2 Public IP (output example):

    Outputs:
    ec2_public_ip = "3.84.xxx.xxx"


## Access the app in your browser:

    http://<EC2_PUBLIC_IP>:3000/


## Project Structure
    terraform/
    │── ec2.tf        # EC2 instance + Security Groups
    │── rds.tf        # RDS MySQL database
    │── s3.tf         # S3 bucket
    │── variables.tf  # Variables
    │── outputs.tf    # Outputs

---
## Security Notes

 -Restrict allowed_cidr to your IP instead of 0.0.0.0/0.

 -Rotate AWS credentials regularly.

 -Never commit .env files or sensitive credentials.

## > This project uses [Terraform](https://developer.hashicorp.com/terraform/docs) for Infrastructure as Code (IaC).
