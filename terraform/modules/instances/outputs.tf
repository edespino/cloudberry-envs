output "INSTANCE_IPS" {
  value = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
}

output "INSTANCE_COUNT" {
  value = length(google_compute_instance.vm)
}
