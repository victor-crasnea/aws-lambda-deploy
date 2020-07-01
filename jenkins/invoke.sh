#!/bin/bash
for (( i = 0; i < 1000; i++ )); do
  aws lambda invoke \
  --function-name test:prod \
  response.json \
  --profile profile --region region
  sleep 1
done