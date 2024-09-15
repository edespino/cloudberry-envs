variable "terraform_project_dir_name" {
  description = "This directory name"
  type        = string
}

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "env_prefix" {
  description = "The environment prefix to use for resource names"
  type        = string
}

variable "vm_count" {
  description = "The number of instances to create"
  type        = number
}

variable "ami" {
  description = "The AMI to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instances"
  type        = string
}

variable "root_disk_size" {
  description = "The size of the root disk in GB"
  type        = number
  default     = 100
}

variable "my_ip" {
  description = "Your current public IP address"
  type        = string
}

variable "data_drive_count" {
  description = "The number of data disks to attach to each instance"
  type        = number
  default     = 4
}

variable "data_drive_size" {
  description = "The size of the data disks in GB"
  type        = number
  default     = 100
}

variable "data_drive_type" {
  description = "The type of the EBS volume (gp2, gp3, io1, io2, st1, sc1)"
  type        = string
  default     = "gp2"
}

variable "iops" {
  description = "The IOPS for provisioned IOPS volumes (only applicable for io1 and io2)"
  type        = number
  default     = 3000
}

variable "throughput" {
  description = "The throughput in MiB/s for gp3 volumes"
  type        = number
  default     = 125
}
