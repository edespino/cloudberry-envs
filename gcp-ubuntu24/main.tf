module "network" {
  source = "../terraform/modules/network"
  
  vm_name    = var.vm_name
  gcp_region = var.gcp_region
  public_ip  = var.public_ip
}

module "ssh_keys" {
  source = "../terraform/modules/ssh_keys"
  vm_count = var.instance_count
}

module "instances" {
  source = "../terraform/modules/instances"
  
  vm_name        = var.vm_name
  gcp_zone       = var.gcp_zone
  instance_count = var.instance_count
  machine_type   = var.machine_type
  boot_image     = var.boot_image
  disk_type      = var.disk_type
  subnet_id      = module.network.subnet_id
  boot_disk_size = var.boot_disk_size
  private_key    = module.ssh_keys.private_key
  public_key     = module.ssh_keys.public_key
}

module "inventory" {
  source         = "../terraform/modules/inventory"
  instance_ips   = module.instances.instance_ips
  instance_count = module.instances.instance_count
}
