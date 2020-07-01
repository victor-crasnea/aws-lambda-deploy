import boto3
import base64
import os
from botocore.session import Session
from botocore.config import Config

# get env vars
function_name = os.environ['LAMBDA_FUNCTION_NAME']
function_version = os.environ['LAMBDA_VERSION']
steps = os.environ['LAMBDA_STEPS']
interval = os.environ['LAMBDA_INTERVAL']


s = Session()
client = s.create_client('lambda', config=Config(connect_timeout=5, read_timeout=600, retries={'max_attempts': 1}))

response = client.invoke(
    FunctionName='LambdaDeploy',
    InvocationType='RequestResponse',
    LogType='Tail',
    Payload='{"function-name": "'+function_name+'","alias-name": "prod","new-version":"'+function_version+'","steps": '+steps+',"interval" : '+interval+',"type": "linear"}'
)

if "FunctionError" in response:
    raise Exception(base64.b64decode(response['LogResult']).decode("utf-8"))
