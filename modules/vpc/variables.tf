variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "demo_vpc"
}
variable "vpc_cidr_block" {
  
  description = "CIDR block for the VPC"
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
    type        = string
  default     = "10.0.202.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
    type        = string
  default     = "10.0.202.0/24"
}


variable "variables_sub_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
  default     = "us-east-1a"
}

variable "public_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
  default     = true
}
variable "private_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
  default     = false
}
