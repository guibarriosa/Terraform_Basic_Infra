module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  cidr = "10.0.0.0/16"

  azs             = ["eu-south-2a", "eu-south-2b", "eu-south-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true


  tags = {
    Name = "${var.tag_name}_Vpc"
  }

  public_subnet_tags = {
    Name = "${var.tag_name}_Public"
  }

  private_subnet_tags = {
    Name = "${var.tag_name}_Private"
  }
}
