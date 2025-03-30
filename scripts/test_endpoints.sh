#!/bin/bash

API_URL="https://REGION-GATEWAY_ID.cloudfunctions.net/process"

echo "Testing API Gateway..."
curl -X GET "$API_URL"
