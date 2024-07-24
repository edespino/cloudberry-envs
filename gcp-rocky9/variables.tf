variable "boot_disk_size" {
  description = "The size of the boot disk for the VM"
  type        = number
  default     = 100
}

variable "boot_image" {
  description = "The boot image for the VM"
  type        = string
  default     = "projects/rocky-linux-cloud/global/images/rocky-linux-9-optimized-gcp-v20240717"
}

variable "disk_type" {
  description = "The disk type for the VM"
  type        = string
  default     = "hyperdisk-balanced"
}

variable "gcp_project" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region"
  type        = string
}

variable "gcp_zone" {
  description = "The GCP zone"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "The machine type for the VM"
  type        = string
  default     = "n4-standard-2"
}

variable "public_ip" {
  description = "Your Mac's public IP address"
  type        = string
}

variable "srvc_acct_file" {
  description = "Path to the service account credential file"
  type        = string
}

variable "vm_name" {
  description = "The VM name suffix"
  type        = string
}
