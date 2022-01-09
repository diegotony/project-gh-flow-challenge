import json
import logging
# import requests


def lambda_handler(event, context):
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
        "message": "Hello {0} your message will be send".format({data["to"]})
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": item,
            # "location": ip.text.replace("\n", "")
        }),
    }
