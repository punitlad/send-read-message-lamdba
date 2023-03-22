module "send_message_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.12.1"

  function_name = "send-message-lambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  source_path   = "send-message-lambda/index.py"
  environment_variables = {
    SQS_URL = aws_sqs_queue.message_queue.url,
    AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
  }

  tracing_mode = "Active"

  layers = [
    "arn:aws:lambda:${var.region}:901920570463:layer:aws-otel-python-amd64-ver-1-16-0:2",
  ]

  lambda_role = module.iam_assumable_role.iam_role_arn
  create_role = false
}

# module "read_message_lambda_nodejs" {
#   source  = "terraform-aws-modules/lambda/aws"
#   version = "~> 4.12.1"

#   function_name = "read-message-lambda-nodejs"
#   handler       = "index.handler"
#   runtime       = "nodejs18.x"
#   source_path   = "read-message-lambda/index.js"
#   event_source_mapping = {
#     sqs = {
#       event_source_arn        = aws_sqs_queue.message_queue.arn
#       function_response_types = ["ReportBatchItemFailures"]
#     }
#   }

#   lambda_role = module.iam_assumable_role.iam_role_arn
#   create_role = false
# }

module "read_message_lambda_python" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.12.1"

  function_name = "read-message-lambda-python"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  source_path   = "read-message-lambda-python/index.py"

  event_source_mapping = {
    sqs = {
      event_source_arn        = aws_sqs_queue.message_queue.arn
      function_response_types = ["ReportBatchItemFailures"]
    }
  }

  tracing_mode = "Active"

  layers = [
    "arn:aws:lambda:${var.region}:901920570463:layer:aws-otel-python-amd64-ver-1-16-0:2",
  ]

  environment_variables = {
    AWS_LAMBDA_EXEC_WRAPPER = "/opt/otel-instrument"
  }

  lambda_role = module.iam_assumable_role.iam_role_arn
  create_role = false
}
