resource "google_compute_network" "network" {
  name                    = "${var.VM_NAME}-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.VM_NAME}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.GCP_REGION
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.VM_NAME}-firewall"
  network = google_compute_network.network.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.PUBLIC_IP, "10.0.1.0/24"]
}
