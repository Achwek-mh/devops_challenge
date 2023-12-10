resource "aws_db_instance" "rds_instance"  {
  identifier            = "rds_instance"
  engine                = "postgres"
  instance_class        = "db.t2.micro"
  name                  = var.db_name
  username              = var.db_username
  password              = var.db_password
  allocated_storage     = 20
  storage_type          = "gp2"
  publicly_accessible   = false
  multi_az              = false
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  db_subnet_group_name  = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "DBInstance"
  }
}

resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Security group for the RDS instance"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [var.subnet_id1, var.subnet_id2]  

  tags = {
    Name = "DBSubnetGroup"
  }
}


output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}
