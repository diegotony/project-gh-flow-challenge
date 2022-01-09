import json
import logging
# import requests


def lambda_handler(event, context):
    print(event)
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