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
