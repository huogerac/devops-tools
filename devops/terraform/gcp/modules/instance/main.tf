resource "google_compute_instance" "default" {
  name         = "${var.environment}-${var.product_name}-vm"
  machine_type = "${var.machine_type}"
  tags         = ["ssh", "http", "https"]

  boot_disk {
    initialize_params {
      image = "${var.so_image}"
    }
  }

  metadata = {
    ssh-keys = "ansible:${file("~/.ssh/ansible.pub")}"
  }

  # Initial setup
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential vim htop rsync;"

  network_interface {
    subnetwork = var.subnet_id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource "google_compute_firewall" "default" {
  name    = "allow-web-and-ssh"
  network = var.vpc_id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  direction = "INGRESS"

  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh", "http", "https"]
}
