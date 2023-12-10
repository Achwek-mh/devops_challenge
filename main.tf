provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  aws_region           = "us-east-1"
}

module "rds" {
  source = "./modules/rds"
  db_name      = "database"
  db_username  = "admin"
  db_password  = "admin"
  aws_region   = "us-east-1"
  subnet_id1   = module.vpc.public_subnet_id
  subnet_id2   = module.vpc.private_subnet_id
}

module "appsync" {
  source = "./modules/appsync"
   vpc_id = module.vpc.vpc_id
  rds_instance = module.rds.rds_instance
  appsync_sg = module.vpc.appsync_sg
}





#outputs 
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "appsync_api_url" {
  value = module.appsync.api_url
}
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}