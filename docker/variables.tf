variable "connection_hosts" {
  type = list(string)
  default = []
}

variable "connection_private_key" {
  type = string
  default = ""
}

variable "containerd_version" {
  type = string
  default = "1.2.13-2"
}

variable "docker_version" {
  type = string
  default = "19.03.11"
}
