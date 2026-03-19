variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
  default = []
}
