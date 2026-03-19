variable "name_prefix" {
  type = string
}

variable "dynamodb_arn" {
  type = string
}

variable "actions" {
  type = list(string)
}
