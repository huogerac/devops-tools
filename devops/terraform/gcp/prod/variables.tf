variable "environment" {
  type    = string
  default = "prod"
}

variable "product_name" {
  type    = string
  default = "dashboard-web"
}

variable "project" {
  type    = string
  default = "my-gcp-project-id"
}

variable "region" {
  type    = string
  default = "europe-west9"
}

variable "zone" {
  type    = string
  default = "europe-west9-a"
}

variable "so_image" {
  type = string
  default = "ubuntu-2204-jammy-v20230727"
}

variable "machine_type" {
  type = string
  default = "e2-micro"
}
