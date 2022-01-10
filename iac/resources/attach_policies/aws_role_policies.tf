data "aws_iam_role" "get_arn_from_role" {
  name = element(split("/", var.role_name),1)
}

resource "aws_iam_role_policy_attachment" "attach_role" {
  role       = data.aws_iam_role.get_arn_from_role.name
  policy_arn = var.policy_arn
}
