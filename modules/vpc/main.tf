
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name                 = "my-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  enable_vpn_gateway   = false
  single_nat_gateway   = true
  public_subnet_tags   = { Name = "public" }
  private_subnet_tags  = { Name = "private" }
  create_database_subnet_group = true




}


