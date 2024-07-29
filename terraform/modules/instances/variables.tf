variable "VM_NAME" {
  description = "The VM name suffix"
  type        = string
}

variable "GCP_USER_NAME" {
  description = "The username to use for SSH connections to the GCP instance"
  type        = string
}

variable "GCP_ZONE" {
  description = "The GCP zone"
  type        = string
}

variable "INSTANCE_COUNT" {
  description = "Number of instances to create"
  type        = number
}

variable "MACHINE_TYPE" {
  description = "The machine type for the VM"
  type        = string
}

variable "BOOT_IMAGE" {
  description = "The boot image for the VM"
  type        = string
}

variable "DISK_TYPE" {
  description = "The disk type for the VM"
  type        = string
}

variable "SUBNET_ID" {
  description = "The ID of the subnet"
  type        = string
}

variable "BOOT_DISK_SIZE" {
  description = "The size of the boot disk for the VM"
  type        = number
}

variable "PRIVATE_KEY" {
  description = "The private key for SSH access"
  type        = string
}

variable "PUBLIC_KEY" {
  description = "The public key for SSH access"
  type        = string
}
