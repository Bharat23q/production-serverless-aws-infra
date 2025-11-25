variable "project_name" {
  description = "Project name used as prefix for resources"
  type        = string
  default     = "mohib-serverless-project-5" 
}

variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1" 
}

variable "aws_account_id" {
  description = "Mohib's AWS account ID"
  type        = string
  default     = "522527377907" 
}

variable "db_name" {
  description = "Database name for the RDS instance"
  type        = string
  default     = "serverless_app"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "app_user" 
}

variable "db_password" {
  description = "Master password for RDS (use secrets manager in real prod!)"
  type        = string
  default     = "DirtyLooks3030"
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "RDS storage in GB"
  type        = number
  default     = 20
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
