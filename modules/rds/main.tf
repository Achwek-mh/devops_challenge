
resource "aws_db_instance" "rds_instance"  {
  

  allocated_storage     = 20
  engine                = "postgres"
  engine_version        = "12.7"
  instance_class        = "db.t2.micro"
  name                  = "mydatabase"
  username              = "admin"
  password              = "your_password"
  publicly_accessible   = false
  subnet_group_name     = module.vpc.database_subnet_group_name
  port = 5432

}
