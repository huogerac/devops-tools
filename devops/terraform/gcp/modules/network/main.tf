resource "google_compute_network" "vpc_network" {
  name                    = "${var.environment}-${var.product_name}vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "${var.environment}-${var.product_name}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id
}