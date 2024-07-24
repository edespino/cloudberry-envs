variable "gcp_region" {
  description = "The GCP region"
  type        = string
}

variable "public_ip" {
  description = "Your Mac's public IP address"
  type        = string
}

variable "vm_name" {
  description = "The VM name suffix"
  type        = string
}
