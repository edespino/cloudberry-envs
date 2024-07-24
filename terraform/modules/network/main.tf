resource "google_compute_network" "network" {
  name                    = "${var.vm_name}-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vm_name}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.vm_name}-firewall"
  network = google_compute_network.network.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.public_ip, "10.0.1.0/24"]
}
