variable "resource_prefix" {
  type = string
  default = "test"
}

variable "droplet_count" {
  type = number
  default = 0
}

variable "droplet_region" {
  type = string
  default = "fra1"
}

variable "droplet_size" {
  type = string
  default = "s-1vcpu-1gb"
}

variable "droplet_image" {
  type = string
  default = "ubuntu-20-04-x64"
}

variable "droplet_user_data" {
  type = string
  default = ""
}

variable "droplet_tags" {
  type = list(string)
  default = []
}
