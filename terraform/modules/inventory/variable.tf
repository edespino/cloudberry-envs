variable "instance_ips" {
  description = "List of instance IPs"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
}
