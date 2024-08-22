### COMMON
variable "environment" {
  type    = string
  default = "prod"
}

variable "region" {
  type = string
  default = "sa-east-1"
}

variable "availability_zone" {
  type = string
  default = "sa-east-1a"
}

### STORAGE - S3 Bucket
variable "embalae_aws_s3_bucket" {
  type = string
  default = "meubucket-prod-bucket"
}

variable "embalae_dns_url" {
  type = string
  default = "meusite.com"
}

### DATABASE - RDS
variable "engine_version" {
  type = string
  default = "15"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "database_name" {
  type = string
  default = "embalaedevdb"
}

variable "database_username" {
  type = string
  default = "embalaedev"
}

variable "database_password" {
  type = string
  default = "colocar-uma-senha-longa-e-segura-aqui"
}

variable "storage" {
  type = number
  default = 20
}


### INSTANCE - EC2
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ami" {
  type = string
  default = "ami-04716897be83e3f04"
}

variable "volume_size" {
  type = string
  default = "20"
}

variable "key_name" {
  type = string
  default = "minha-chave"
}

variable "backend_port" {
  type = number
  default = 8000
}
