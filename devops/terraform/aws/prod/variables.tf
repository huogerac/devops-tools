
# GERAL
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

# EC2
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
  default = "minha_chave.pem_criada_na_aws"
}

variable "backend_port" {
  type = number
  default = 8000
}

# DATABASE
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
  default = "djangodb"
}

variable "database_username" {
  type = string
  default = "djangodbuser"
}

variable "database_password" {
  type = string
  default = "484b324fc497X20b24_trocar_e_nao_manter_isto_no_git"
}

variable "storage" {
  type = number
  default = 20
}
