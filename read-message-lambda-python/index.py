import json
import boto3
import logging

logging.basicConfig()
logger = logging.getLogger("read-message-lambda-python")

def lambda_handler(event, context):
    print("Triggered based on sqs message")
    print(event["Records"][0]["body"])
    return {
        'statusCode': 200,
        'body': json.dumps("Goodbye from Lambda!")
    }
