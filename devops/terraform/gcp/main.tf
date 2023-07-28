provider "google" {
  project = "my-project-id"
  region  = "europe-west9"
  zone    = "europe-west9-a"
}


## 1 -- network
resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "my-custom-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id
}


## 2 - Instance
resource "google_compute_instance" "default" {
  name         = "dashboard-vm"
  machine_type = "e2-micro"
  tags         = ["ssh","http","https"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20230727"
    }
  }

  metadata = {
    ssh-keys = "ansible:${file("~/.ssh/ansible.pub")}"
  }

  # Initial setup
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential vim htop rsync;"

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}

resource "google_compute_firewall" "default" {
  name    = "allow-web-and-ssh"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  direction     = "INGRESS"
  
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh", "http", "https"]
}
