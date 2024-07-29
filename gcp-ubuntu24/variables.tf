variable "GCP_USER_NAME" {
  description = "The username to use for SSH connections to the GCP instance"
  type        = string
}

variable "BOOT_DISK_SIZE" {
  description = "The size of the boot disk for the VM"
  type        = number
  default     = 100
}

variable "BOOT_IMAGE" {
  description = "The boot image for the VM"
  type        = string
}

variable "DISK_TYPE" {
  description = "The disk type for the VM"
  type        = string
  default     = "hyperdisk-balanced"
}

variable "GCP_PROJECT" {
  description = "The GCP project ID"
  type        = string
}

variable "GCP_REGION" {
  description = "The GCP region"
  type        = string
}

variable "GCP_ZONE" {
  description = "The GCP zone"
  type        = string
}

variable "INSTANCE_COUNT" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "MACHINE_TYPE" {
  description = "The machine type for the VM"
  type        = string
  default     = "n4-standard-2"
}

variable "PUBLIC_IP" {
  description = "Your local host's public IP address"
  type        = string
}

variable "SRVC_ACCT_FILE" {
  description = "Path to the service account credential file"
  type        = string
}

variable "VM_NAME" {
  description = "The VM name suffix"
  type        = string
}
