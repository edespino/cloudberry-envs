module "network" {
  source = "../terraform/modules/network"

  VM_NAME    = var.VM_NAME
  GCP_REGION = var.GCP_REGION
  PUBLIC_IP  = var.PUBLIC_IP
}

module "ssh_keys" {
  source = "../terraform/modules/ssh_keys"
  VM_COUNT = var.INSTANCE_COUNT
}

module "instances" {
  source = "../terraform/modules/instances"

  VM_NAME        = var.VM_NAME
  GCP_ZONE       = var.GCP_ZONE
  GCP_USER_NAME  = var.GCP_USER_NAME
  INSTANCE_COUNT = var.INSTANCE_COUNT
  MACHINE_TYPE   = var.MACHINE_TYPE
  BOOT_IMAGE     = var.BOOT_IMAGE
  DISK_TYPE      = var.DISK_TYPE
  SUBNET_ID      = module.network.subnet_id
  BOOT_DISK_SIZE = var.BOOT_DISK_SIZE
  PRIVATE_KEY    = module.ssh_keys.PRIVATE_KEY
  PUBLIC_KEY     = module.ssh_keys.PUBLIC_KEY
}

module "inventory" {
  source         = "../terraform/modules/inventory"
  INSTANCE_IPS   = module.instances.INSTANCE_IPS
  INSTANCE_COUNT = module.instances.INSTANCE_COUNT
}
