
variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "database"
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  default     = "admin"
}

variable "aws_region" {
  description = "AWS region"
  type    = string
  default = "us-east-1"
}
variable "subnet_id1" {
  type    = string
  description = "ID of the first subnet"
}

variable "subnet_id2" {
  type    = string
  description = "ID of the second subnet"
}