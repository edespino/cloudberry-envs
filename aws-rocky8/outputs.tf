output "instance_public_ips" {
  description = "The public IP addresses of the Rocky Linux instances"
  value = aws_instance.rocky_linux[*].public_ip
}

output "instance_private_ips" {
  description = "The public IP addresses of the Rocky Linux instances"
  value = aws_instance.rocky_linux[*].private_ip
}

output "instance_private_nic_ips" {
  description = "The public IP addresses of the Rocky Linux instances"
  value = aws_network_interface.private_nic[*].private_ip
}

output "instance_names" {
  description = "The names of the Rocky Linux instances"
  value = aws_instance.rocky_linux[*].tags.Name
}

output "private_ips" {
  value = aws_network_interface.private_nic[*].private_ip
}
