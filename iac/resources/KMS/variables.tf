variable "alias_name" {}
variable "arn_managers_group" {}
variable "arn_readers_group" {}

variable "description" {
  type    = string
  default = "createdBy: ops-team"
}

variable "deletion_in_days" {
  type    = number
  default = 30
}

variable "key_usage" {
  type    = string
  default = "ENCRYPT_DECRYPT"
}

variable "enabled" {
  type    = bool
  default = true
}

variable "enable_rotation" {
  type    = bool
  default = false
}
