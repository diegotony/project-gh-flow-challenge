output "kms_key_id" {
  value = aws_kms_key.full.id
}

output "kms_arn" {
  value = aws_kms_key.full.arn
}