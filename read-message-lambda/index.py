import json
import boto3
import logging

logging.basicConfig()
logger = logging.getLogger("read-message-lambda")

def lambda_handler(event, context):
    logger.info("Triggered from sqs message")
    logger.info(event["Records"][0]["body"])
    return {
        'statusCode': 200,
        'body': json.dumps("Goodbye from Lambda!")
    }
