variable "vm_name" {
  description = "The VM name suffix"
  type        = string
}

variable "gcp_zone" {
  description = "The GCP zone"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}

variable "machine_type" {
  description = "The machine type for the VM"
  type        = string
}

variable "boot_image" {
  description = "The boot image for the VM"
  type        = string
}

variable "disk_type" {
  description = "The disk type for the VM"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "boot_disk_size" {
  description = "The size of the boot disk for the VM"
  type        = number
}

variable "private_key" {
  description = "The private key for SSH access"
  type        = string
}

variable "public_key" {
  description = "The public key for SSH access"
  type        = string
}
