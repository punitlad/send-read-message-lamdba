module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.12.1"

  function_name = "send-message-lambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  source_path   = "../send-message-lambda/index.py"
  environment_variables = {
    SQS_URL = aws_sqs_queue.message_queue.url
  }

  lambda_role = module.iam_assumable_role.iam_role_arn
  create_role = false
}

resource "aws_sqs_queue" "message_queue" {
  name = "message-queue"
}

module "lambda_function_two" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.12.1"

  function_name = "read-message-lambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  source_path   = "../read-message-lambda/index.py"
  event_source_mapping = {
    sqs = {
      event_source_arn        = aws_sqs_queue.message_queue.arn
      function_response_types = ["ReportBatchItemFailures"]
    }
  }

  lambda_role = module.iam_assumable_role.iam_role_arn
  create_role = false
}