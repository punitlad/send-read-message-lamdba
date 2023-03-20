import json
import boto3
import os

def lambda_handler(event, context):
    sqs = boto3.client('sqs')
    sqs.send_message(
        QueueUrl=os.environ['SQS_URL'],
        MessageBody="some message"
    )
    return {
        'statusCode': 200,
        'body': json.dumps("Hello from Lambda!")
    }
