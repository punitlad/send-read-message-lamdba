import json
import boto3
import os
import uuid
import logging

logging.basicConfig()
logger = logging.getLogger("send-message-lambda")

def lambda_handler(event, context):
    sqs = boto3.client('sqs')
    send_message_id = uuid.uuid4()
    logger.info("ID: {id}".format(id=send_message_id))
    sqs.send_message(
        QueueUrl=os.environ['SQS_URL'],
        MessageBody="Send Message ID: {id}".format(id=send_message_id)
    )
    return {
        'statusCode': 200,
        'body': json.dumps("Hello from Lambda!")
    }
