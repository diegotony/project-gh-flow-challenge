variable "policy_name" {}

variable "resources_arn" {
  type = list(string)
}

variable "path" {
  type    = string
  default = "/"
}

variable "description" {
  type    = string
  default = "createdBy: ops-team"
}

variable "custom_actions" {
  type    = list(string)
  default = ["secretsmanager:GetSecretValue", "kms:Decrypt"]
}

