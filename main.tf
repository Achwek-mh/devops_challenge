provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source = "./modules/rds"
}

module "appsync" {
  source = "./modules/appsync"
   vpc_id = module.vpc.vpc_id
  rds_instance = module.rds.rds_instance
  appsync_sg = module.vpc.appsync_sg
}


