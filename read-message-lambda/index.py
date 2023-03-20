import json
import boto3

def lambda_handler(event, context):
    print("Triggered from sqs message")
    print(event)
    return {
        'statusCode': 200,
        'body': json.dumps("Goodbye from Lambda!")
    }
