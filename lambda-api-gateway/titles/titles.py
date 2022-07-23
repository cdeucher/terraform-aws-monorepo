import os
import boto3
import json
import logging
from datetime import datetime;

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb_client = boto3.client('dynamodb')

if os.environ.get('IS_OFFLINE'):
    dynamodb_client = boto3.client(
        'dynamodb', region_name='localhost', endpoint_url='http://localhost:8000'
    )

TITLES_TABLE = os.environ.get('TITLES_TABLE', 'titles')


def get_title(text):
    result = dynamodb_client.get_item(
        TableName=TITLES_TABLE, Key={'text': {'S': text}}
    )
    item = result.get('Item')
    if not item:
        return jsonify({'error': 'Could not find title with provided "text"'}), 404

    return jsonify(
        {
            'text': item.get('text').get('S')
        ,   'price': item.get('price').get('S')
        ,   'symbol': item.get('symbol').get('S')
        ,   'url': item.get('url').get('S')
        ,   'type': item.get('type').get('S')
        }
    )


def api_addtitle(event, context):
    logger.info("Request: %s", event)
    response_body = {'error': 'Unprocessable Entity'}
    response_code = 422
    date_now = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    body = event.get('body')

    if body is not None and isinstance(body, dict):
        text = json.loads(body).get('text')
        price = json.loads(body).get('price')
        symbol = json.loads(body).get('symbol')
        url = json.loads(body).get('url')
        price_type = json.loads(body).get('type')

        if not text or not price:
            response_body = {'error': 'Please provide both "text" and "price"'}
            response_code = 400
        else:
            dynamodb_client.put_item(
                TableName=TITLES_TABLE, Item={
                    'text': {'S': text}
                    , 'price': {'S': price}
                    , 'symbol': {'S': symbol}
                    , 'url': {'S': url}
                    , 'type': {'S': price_type}
                    , 'date': {'S': date_now}
                }
            )
            response_body = {'text': text, 'name': price}
            response_code = 200
    else:
        list_titles = json.loads(body);
        for title in list_titles:
            print(title)
            dynamodb_client.put_item(
                TableName=TITLES_TABLE, Item={
                    'text': {'S': title.get('text')}
                    , 'price': {'S': title.get('price')}
                    , 'symbol': {'S': title.get('symbol')}
                    , 'url': {'S': title.get('url')}
                    , 'type': {'S': title.get('type')}
                    , 'date': {'S': date_now}
                }
            )
        response_body = {'list': 'ok', 'count': list_titles.__len__()}
        response_code = 200            

    response = {
        'statusCode': response_code,
        'body': json.dumps(response_body)
    }

    logger.info("Response: %s", response)
    return response


def list_titles():
    result = dynamodb_client.scan(
        TableName=TITLES_TABLE
    )
    items = result.get('Items')
    return jsonify(items)
