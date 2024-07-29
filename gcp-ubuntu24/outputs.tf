output "INSTANCE_IPS" {
  value = module.instances.INSTANCE_IPS
}

output "INSTANCE_COUNT" {
  value = module.instances.INSTANCE_COUNT
}

output "INVENTORY_FILE" {
  value = "${path.root}/inventory.ini"
}

output "PRIVATE_KEY_PATH" {
  value = "${path.root}/ssh_keys/id_rsa-VMs"
}
