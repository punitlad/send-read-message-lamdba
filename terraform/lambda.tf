module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.12.1"

  function_name = "send-message-lambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  source_path   = "../send-message-lambda/index.py"

  lambda_role = module.iam_assumable_role.iam_role_arn
  create_role = false
}

resource "aws_sqs_queue" "message_queue" {
  name = "message-queue"
}