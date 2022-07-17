import os
import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb_client = boto3.client('dynamodb')

if os.environ.get('IS_OFFLINE'):
    dynamodb_client = boto3.client(
        'dynamodb', region_name='localhost', endpoint_url='http://localhost:8000'
    )

USERS_TABLE = os.environ.get('USERS_TABLE', 'users')


def get_user(user_id):
    result = dynamodb_client.get_item(
        TableName=USERS_TABLE, Key={'userId': {'S': user_id}}
    )
    item = result.get('Item')
    if not item:
        return jsonify({'error': 'Could not find user with provided "userId"'}), 404

    return jsonify(
        {'userId': item.get('userId').get('S'), 'name': item.get('name').get('S')}
    )


def api_adduser(event, context):
    logger.info("Request: %s", event)
    response_body = {'error': 'Unprocessable Entity'}
    response_code = 422
    body = event.get('body')
    if body is not None:
        user_id = json.loads(body).get('userId')
        name = json.loads(body).get('name')

    if not user_id or not name:
        response_body = {'error': 'Please provide both "userId" and "name"'}
        response_code = 400
    else:
        dynamodb_client.put_item(
            TableName=USERS_TABLE, Item={'userId': {'S': user_id}, 'name': {'S': name}}
        )
        response_body = {'userId': user_id, 'name': name}
        response_code = 200

    response = {
        'statusCode': response_code,
        'body': json.dumps(response_body)
    }

    logger.info("Response: %s", response)
    return response


def list_users():
    result = dynamodb_client.scan(
        TableName=USERS_TABLE
    )
    items = result.get('Items')
    return jsonify(items)
