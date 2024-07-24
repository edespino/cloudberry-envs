output "instance_ips" {
  value = module.instances.instance_ips
}

output "instance_count" {
  value = module.instances.instance_count
}

output "inventory_file" {
  value = "${path.root}/inventory.ini"
}

output "private_key_path" {
  value = "${path.root}/ssh_keys/id_rsa-VMs"
}
