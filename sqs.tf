resource "aws_sqs_queue" "message_queue" {
  #checkov:skip=CKV_AWS_27: This is just a test queue; not for production usage
  name = "message-queue"
}
