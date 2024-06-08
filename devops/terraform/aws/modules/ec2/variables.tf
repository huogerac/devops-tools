variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami" {
  type = string
}

variable "volume_size" {
  type = string
}

variable "key_name" {
    type = string
}

variable "backend_port" {
    type = number
}