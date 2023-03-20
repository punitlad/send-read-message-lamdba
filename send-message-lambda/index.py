import json
import boto3
import os
import uuid
import logging

def lambda_handler(event, context):
    logging.getLogger().addHandler(logging.StreamHandler())
    logger = logging.getLogger("send-message-lambda")

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
