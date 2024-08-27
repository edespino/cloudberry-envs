output "instance_ips" {
  description = "The public IP addresses of the Rocky Linux instances"
  value = aws_instance.linux_instance[*].public_ip
}

output "instance_names" {
  description = "The names of the Rocky Linux instances"
  value = aws_instance.linux_instance[*].tags.Name
}
