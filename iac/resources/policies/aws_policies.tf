resource "aws_iam_policy" "decrypt_secrets" {
  name        = var.policy_name
  path        = var.path
  description = var.description

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action":  ${jsonencode(var.custom_actions)},
            "Resource": ${jsonencode(var.resources_arn)}
        }
    ]
}
EOF
}