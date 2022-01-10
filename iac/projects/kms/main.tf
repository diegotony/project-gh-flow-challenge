data "aws_iam_group" "get_arn_managers_group" {
  group_name = "developers"
}

module "kms-backend" {
  source             = "../../resources/KMS"
  alias_name         = "gh-flow-secrets"
  arn_managers_group = data.aws_iam_group.get_arn_managers_group.users[*].arn
  arn_readers_group  = data.aws_iam_group.get_arn_managers_group.users[*].arn
  deletion_in_days   = 21
  description        = "KMS KEY"
}

module "jwt" {
  source      = "../../resources/secret_manager"
  secret_name = "jwt"
  kms_id      = module.kms-backend.kms_key_id
  default_secrets = var.JWT

}

module "api-key" {
  source      = "../../resources/secret_manager"
  secret_name = "api-key"
  kms_id      = module.kms-backend.kms_key_id
  default_secrets = var.API_KEY

}

module "policies-api-key" {
  source        = "../../resources/policies"
  policy_name   = "policy-decrypt-secrets-api-key"
  resources_arn = [module.kms-backend.kms_arn, module.api-key.secret_arn]
}

module "policies-jwt" {
  source        = "../../resources/policies"
  policy_name   = "policy-decrypt-secrets-jwt"
  resources_arn = [module.kms-backend.kms_arn, module.jwt.secret_arn]
}


data "aws_lambda_function" "devops" {
  function_name = "gh-flow-devopsFunction"
}

module "attach-policy-api-key-devops" {
  source     = "../../resources/attach_policies"
  role_name  = data.aws_lambda_function.devops.role
  policy_arn = module.policies-api-key.policy_arn
}


module "attach-policy-jwt-devops" {
  source     = "../../resources/attach_policies"
  role_name  = data.aws_lambda_function.devops.role
  policy_arn = module.policies-jwt.policy_arn
}
