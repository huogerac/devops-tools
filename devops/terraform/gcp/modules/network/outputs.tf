output "subnet_id" {
  value = google_compute_subnetwork.default.id
}

output "vpc_id" {
  value = google_compute_network.vpc_network.id
}
