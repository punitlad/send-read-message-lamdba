resource "aws_sqs_queue" "message_queue" {
  name = "message-queue"
  kms_master_key_id                 = aws_kms_key.sqs_kms_key.arn
  kms_data_key_reuse_period_seconds = 300
}

resource "aws_kms_key" "sqs_kms_key" {
  description             = "sqs-kms-key"
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation    = true
}
