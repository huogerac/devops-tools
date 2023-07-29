provider "google" {
  project = "my-project-id"
  region  = "europe-west9"
  zone    = "europe-west9-a"
}

module "instance" {
  source       = "../modules/instance"
  environment  = var.environment
  product_name = var.product_name
  subnet_id    = module.network.subnet_id
  vpc_id       = module.network.vpc_id
}

module "network" {
  source       = "../modules/network"
  environment  = var.environment
  product_name = var.product_name
}
