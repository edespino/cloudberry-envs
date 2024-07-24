output "instance_ips" {
  value = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
}

output "instance_count" {
  value = length(google_compute_instance.vm)
}
