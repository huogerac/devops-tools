variable "aws_region" {
  default = "us-west-2"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "storage" {
  default     = "20"
  description = "Storage size in GB"
}

variable "engine_version" {
  description = "Engine version"
  default = "12"
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance type for the RDS Database. Example: db.t2.large"
}

variable "database_name" {
  default     = "mydb-dev"
  description = "RDS DB name"
}

variable "database_username" {
  default     = "mydbdev"
  description = "RDS DB username"
}

variable "database_password" {
  description = "RDS DB password. Example: XYdKaM4SaWeB2020"
}
