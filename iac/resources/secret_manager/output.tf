output "secret_arn" {
  value = aws_secretsmanager_secret_version.basic.arn
}