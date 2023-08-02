provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "instance" {
  source       = "../modules/instance"
  environment  = var.environment
  product_name = var.product_name
  so_image     = var.so_image
  machine_type = var.machine_type
  subnet_id    = module.network.subnet_id
  vpc_id       = module.network.vpc_id
}

module "network" {
  source       = "../modules/network"
  environment  = var.environment
  product_name = var.product_name
}
