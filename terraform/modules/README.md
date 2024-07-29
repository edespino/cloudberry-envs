
# Terraform Modules

This directory contains reusable Terraform modules for various projects, including but not limited to the GCP RL9 project.

## Modules

### Network

This module sets up the network infrastructure.

**Directory**: `modules/network`

### Instances

This module sets up the compute instances.

**Directory**: `modules/instances`

### SSH Keys

This module manages the generation and cleanup of SSH keys.

**Directory**: `modules/ssh_keys`

## Usage

To use these modules, reference them in your Terraform configuration. Below is an example usage from the `gcp-rl9` project:

```hcl
module "network" {
  source = "../terraform/modules/network"

  vm_name    = var.VM_NAME
  gcp_region = var.GCP_REGION
  public_ip  = var.PUBLIC_IP
}

module "ssh_keys" {
  source = "../terraform/modules/ssh_keys"
  vm_count = var.INSTANCE_COUNT
}

module "instances" {
  source = "../terraform/modules/instances"

  vm_name        = var.VM_NAME
  gcp_zone       = var.GCP_ZONE
  instance_count = var.INSTANCE_COUNT
  machine_type   = var.MACHINE_TYPE
  boot_image     = var.BOOT_IMAGE
  disk_type      = var.DISK_TYPE
  subnet_id      = module.network.subnet_id
  boot_disk_size = var.BOOT_DISK_SIZE
  private_key    = module.ssh_keys.private_key
  public_key     = module.ssh_keys.public_key
}

module "inventory" {
  source         = "../terraform/modules/inventory"
  instance_ips   = module.instances.instance_ips
  instance_count = module.instances.instance_count
}```

## Directory Structure

```
modules/
  network/
    main.tf
    variables.tf
    outputs.tf
  instances/
    main.tf
    variables.tf
    outputs.tf
  inventory/
    main.tf
    variables.tf
  ssh_keys/
    main.tf
    variables.tf
    outputs.tf
```

## Additional Projects

Other projects can also use these modules by referencing them in their own Terraform configurations. Ensure to update the module source path accordingly.
