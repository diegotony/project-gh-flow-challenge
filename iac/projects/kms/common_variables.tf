# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa

variable "tg_common_tags" {
  description = "Common tags for all AWS resources - (Generated by terragrunt)"
  default = {
    env       = "prod"
    details   = "Resource related to the gh-flow project"
    app       = "gh-flow"
    org       = "gh-flow"
    createdBy = "ops-team"
  }
}

variable "tg_aws_region" {
  description = "AWS region to be deploy Intranet - (Generated by terragrunt)"
  default     = "us-east-2"
}

variable "tg_app_name" {
  description = "Application name - (Generated by terragrunt)"
  default     = "gh-flow"
}

variable "tg_org_name" {
  description = "Organization name - (Generated by terragrunt)"
  default     = "gh-flow"
}


