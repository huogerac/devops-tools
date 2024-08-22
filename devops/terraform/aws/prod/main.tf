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

### STORAGE
module "s3" {
  source = "../modules/s3"

  environment  = var.environment
  region = var.region
  embalae_dns_url = var.embalae_dns_url
  embalae_aws_s3_bucket = var.embalae_aws_s3_bucket
}

output "AWS_ACCESS_KEY_ID" {
  value = module.s3.access_key_id
}

output "AWS_SECRET_ACCESS_KEY" {
  sensitive = true
  value = module.s3.secret_access_key
}

output "BUCKET_PUBLIC" {
  value = module.s3.bucket_public
}

output "BUCKET_PRIVATE" {
  value = module.s3.bucket_private
}


## DATABASE
# module "rds" {
#   source       = "../modules/rds"
#   environment = var.environment
#   region = var.region
#   availability_zone = var.availability_zone
#   engine_version = var.engine_version
#   instance_class = var.instance_class
#   database_name = var.database_name
#   database_username = var.database_username
#   database_password = var.database_password
#   storage = var.storage
# }

# output "DATABASE_ENDPOINT" {
#   value = module.rds.endpoint
# }

# output "DATABASE_PORT" {
#   value = module.rds.port
# }


### INSTANCES
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
  embalae_dns_url = var.embalae_dns_url
}
output "INSTANCE_PRIVATE_DNS" {
  value = module.ec2.private_dns
}
output "INSTANCE_PRIVATE_IP" {
  value = module.ec2.private_ip
}
output "ELASTIC_IP_PUBLIC_DNS" {
  value = module.ec2.elastic_public_dns
}
output "ELASTIC_IP_PUBLIC_IP" {
  value = module.ec2.elastic_public_ip
}