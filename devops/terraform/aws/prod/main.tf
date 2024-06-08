terraform {                                      #this is we tell terraform we config AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# TODO: Falta colocar configuração para manter o STATE no S3

module "ec2" {
  source       = "../modules/ec2"
  environment  = var.environment
  region = var.region
  availability_zone = var.availability_zone
  instance_type = var.instance_type
  ami = var.ami
  volume_size = var.volume_size
  key_name = var.key_name
  backend_port = var.backend_port
}

module "rds" {
  source       = "../modules/rds"
  environment = var.environment
  region = var.region
  availability_zone = var.availability_zone
  engine_version = var.engine_version
  instance_class = var.instance_class
  database_name = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  storage = var.storage
}
