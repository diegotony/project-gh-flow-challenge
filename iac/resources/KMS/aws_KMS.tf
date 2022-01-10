
resource "aws_kms_key" "full" {
  description             = var.description
  deletion_window_in_days = var.deletion_in_days
  key_usage               = var.key_usage
  is_enabled              = var.enabled
  enable_key_rotation     = var.enable_rotation
  policy                  = <<EOF
{
   "Id": "key-consolepolicy-3",
   "Version": "2012-10-17",
   "Statement": [
      {
         "Sid": "Enable IAM User Permissions",
         "Effect": "Allow",
         "Principal": {
            "AWS": "arn:aws:iam::237918751012:root"
         },
         "Action": "kms:*",
         "Resource": "*"
      },
      {
         "Sid": "Allow access for Key Administrators - ",
         "Effect": "Allow",
         "Principal": {
            "AWS": ${jsonencode(var.arn_managers_group)}
         },
         "Action": [
            "kms:Create*",
            "kms:Describe*",
            "kms:Enable*",
            "kms:List*",
            "kms:Put*",
            "kms:Update*",
            "kms:Revoke*",
            "kms:Disable*",
            "kms:Get*",
            "kms:Delete*",
            "kms:TagResource",
            "kms:UntagResource",
            "kms:ScheduleKeyDeletion",
            "kms:CancelKeyDeletion"
         ],
         "Resource": "*"
      },
      {
         "Sid": "Allow use of the key",
         "Effect": "Allow",
         "Principal": {
            "AWS": ${jsonencode(var.arn_readers_group)}
         },
         "Action": [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
         ],
         "Resource": "*"
      }
   ]
}
EOF
}

resource "aws_kms_alias" "full" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.full.key_id
  depends_on    = [aws_kms_key.full]
}
