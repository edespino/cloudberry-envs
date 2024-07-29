variable "INSTANCE_IPS" {
  description = "List of instance IPs"
  type        = list(string)
}

variable "INSTANCE_COUNT" {
  description = "Number of instances"
  type        = number
}
