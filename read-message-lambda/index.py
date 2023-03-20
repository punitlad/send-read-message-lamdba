import json
import boto3
import logging

def lambda_handler(event, context):
    logging.getLogger().addHandler(logging.StreamHandler())

    logging.info("Triggered from sqs message")
    logging.info(event["Records"][0]["body"])
    return {
        'statusCode': 200,
        'body': json.dumps("Goodbye from Lambda!")
    }
