import json
import logging
import boto3
import base64
from botocore.exceptions import ClientError

API_KEY=""
JWT=""

def lambda_handler(event, context):
    
    region_name = "us-east-2"
    secret_name = "arn:aws:secretsmanager:us-east-2:237918751012:secret:api-key-gRwx11"

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )
    get_secret_value_response = client.get_secret_value(
        SecretId=secret_name
    )
    
    # Decrypts secret using the associated KMS key.
    # Depending on whether the secret is a string or binary, one of these fields will be populated.
    if 'SecretString' in get_secret_value_response:
        secret = get_secret_value_response['SecretString']
        data=json.loads(secret)
        API_KEY = str(data["API_KEY"])
        print(API_KEY)
    else:
        decoded_binary_secret = base64.b64decode(get_secret_value_response['SecretBinary'])


    secret_name = "arn:aws:secretsmanager:us-east-2:237918751012:secret:jwt-XVWWb3"

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )
    get_secret_value_response = client.get_secret_value(
        SecretId=secret_name
    )
    
    # Decrypts secret using the associated KMS key.
    # Depending on whether the secret is a string or binary, one of these fields will be populated.
    if 'SecretString' in get_secret_value_response:
        secret = get_secret_value_response['SecretString']
        data=json.loads(secret)
        JWT = str(data["JWT"])
        print(JWT)
    else:
        decoded_binary_secret = base64.b64decode(get_secret_value_response['SecretBinary'])
    
    try:
        print(event["headers"])
        if event["headers"]["x-parse-rest-api-key"] == API_KEY and event["headers"]["x-jwt-kwy"] == JWT:
            if event["httpMethod"] == "POST":
                data = json.loads(event["body"])
                if 'message' not in data:
                    logging.error("Validation Failed")
                    raise Exception("Couldn't send message missing message")
                if 'to' not in data:
                    logging.error("Validation Failed")
                    raise Exception("Couldn't send message missing to ")

                if 'from' not in data:
                    logging.error("Validation Failed")
                    raise Exception("Couldn't send message missing from")

                if 'timeToLifeSec' not in data:
                    logging.error("Validation Failed")
                    raise Exception("Couldn't send message missing timeToLifeSec")


                item = {
                    "message": "Hello {0} your message will be send".format(str(data["to"]))
                }

                response = {
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "statusCode": 200,
                    "body": json.dumps(item)
                }

                return response
            else:
                response = {
                    "headers": {
                        "Content-Type": "application/json"
                    },
                    "statusCode": 200,
                    "body": "ERROR"
                }
                return response
        else:
            response = {
                "headers": {
                    "Content-Type": "application/json"
                },
                "statusCode": 200,
                "body": "ERROR"
            }
            return response
    except:
        response = {
        "headers": {
            "Content-Type": "application/json"
        },
        "statusCode": 200,
        "body": "ERROR"
        }
        return response       
    