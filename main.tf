provider "aws" {
  region = "us-east-1"
}
module "vpc" {
  source = "./modules/vpc"
  environment = var.environment
  aws_region   = var.aws_region
}
module "rds" {
  source = "./modules/rds"
  environment = var.environment
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  aws_region  = var.aws_region
  subnet_id1   = module.vpc.public_subnet_id
  subnet_id2   = module.vpc.private_subnet_id
}
module "appsync" {
  source = "./modules/appsync"
  environment = var.environment
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