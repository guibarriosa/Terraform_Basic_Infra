# Terraform AWS Basic Infrastructure

## Overview
This repository contains Terraform code that provisions a basic and real AWS infrastructure, which includes:

- VPC with public and private subnets
- Auto Scaling Group (ASG)
- EC2 Launch Template
- RDS (MySQL) in a private subnet
- CloudWatch alarms
- IAM Roles and policies 
- EC2 access via SSM (SSH access is also available, but commented)

## Technologies
- Terraform 
- AWS (EC2, ASG, RDS, IAM, SSM, CloudWatch)

## Requirements
- Terraform >= 1.5
- AWS account
- CLI configured (`aws configure`)
- IAM user with sufficient permissions (Mostly PowerUserAccess was used, AdminAccess was temporarily required for testing SSM)

## Setup

```bash
git clone https://github.com/guibarriosa/Terraform_Basic_Infra.git
cd Terraform_Basic_Infra
cp terraform.example.tfvars terraform.tfvars
```

## Deployment
```bash
terraform init
terraform plan
terraform apply
```

To destroy the infra:
```bash
terraform destroy
```

## Additional Notes
If you want to test EC2 connection via SSH, uncomment the code and create a key pair in AWS:
- Go to EC2 → Key Pairs → Create key pair (RSA, .pem)
- Download the file
- Connect via SSH: 
```bash
ssh -i "C:/path/to/key.pem" ec2-user@<EC2_Public_IP>
```

## Personal Note
This was tested on my personal aws account in eu-south-2. So please make sure your account/region and this configuration are matching.



