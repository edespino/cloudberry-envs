output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "network_id" {
  value = google_compute_network.network.id
}
