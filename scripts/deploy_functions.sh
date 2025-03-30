#!/bin/bash

PROJECT_ID="YOUR_PROJECT_ID"
REGION="us-central1"

# Deploy API Handler
gcloud functions deploy apiHandler \
    --runtime python39 --trigger-http --allow-unauthenticated \
    --entry-point process_request --region $REGION

# Deploy SMS Service
gcloud functions deploy smsService \
    --runtime python39 --trigger-http --allow-unauthenticated \
    --entry-point send_sms --region $REGION

# Deploy Email Service
gcloud functions deploy emailService \
    --runtime python39 --trigger-http --allow-unauthenticated \
    --entry-point send_email --region $REGION

# Deploy Workflow
gcloud workflows deploy v2c-workflow --source=infrastructure/workflow.yaml --region $REGION
