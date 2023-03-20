module "iam_assumable_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version     = "~> 5.1"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]

  create_role = true
  role_name   = "send-message-lambda-role"
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]
  number_of_custom_role_policy_arns = 1
}

module "iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "send-message-lambda-policy"
  path        = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:${var.region}:${var.account_id}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/lambda/send-message-lambda:*"
            ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "sqs:SendMessage",
            "sqs:ReceiveMessage",
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes"
          ],
          "Resource": [
            "arn:aws:sqs:${var.region}:${var.account_id}:message-queue"
          ]
        }
    ]
}
EOF
}