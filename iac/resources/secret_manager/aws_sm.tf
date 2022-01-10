
resource "aws_secretsmanager_secret" "basic" {
  name        = var.secret_name
  kms_key_id  = var.kms_id
  description = var.description
}

resource "aws_secretsmanager_secret_version" "basic" {
  secret_id     = aws_secretsmanager_secret.basic.id
  secret_string = jsonencode(var.default_secrets)
}
