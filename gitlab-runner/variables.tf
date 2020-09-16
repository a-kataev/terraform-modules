variable "connection_hosts" {
  type = list(string)
  default = []
}

variable "connection_private_key" {
  type = string
  default = ""
}

variable "registration_token" {
  type = string
  default = ""
}

variable "tag_list" {
  type = list(string)
  default = []
}
