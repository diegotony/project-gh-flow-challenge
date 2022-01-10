variable "secret_name" {}

variable "kms_id" {}

variable "description" {
  type    = string
  default = ""
}

variable "default_secrets" {
  default = {
    testSecret = "SuperSecret123$"
  }
  type = map
}