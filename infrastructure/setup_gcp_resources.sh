#!/bin/bash

# Set project and region
PROJECT_ID="your-gcp-project-id"
REGION="us-central1"

echo "Setting up GCP resources for V2C..."

# Enable required services
echo "Enabling required APIs..."
gcloud services enable cloudfunctions.googleapis.com \
    run.googleapis.com \
    apigateway.googleapis.com \
    workflows.googleapis.com \
    cloudbuild.googleapis.com \
    cloudresourcemanager.googleapis.com \
    iam.googleapis.com \
    artifactregistry.googleapis.com

# Create Artifact Registry (optional, for Cloud Run deployment)
echo "Creating Artifact Registry..."
gcloud artifacts repositories create v2c-repo --repository-format=Docker --location=$REGION

# Create API Gateway
echo "Creating API Gateway..."
gcloud api-gateway apis create v2c-api --project=$PROJECT_ID

# Deploy API Gateway Config
echo "Deploying API Gateway Configuration..."
gcloud api-gateway api-configs create v2c-api-config \
    --api=v2c-api --openapi-spec=infrastructure/api_gateway.yaml --project=$PROJECT_ID

# Deploy Cloud Functions
echo "Deploying Cloud Functions..."
gcloud functions deploy apiHandler \
    --runtime python39 --trigger-http --allow-unauthenticated \
    --entry-point process_request --region $REGION

gcloud functions deploy smsService \
    --runtime python39 --trigger-http --allow-unauthenticated \
    --entry-point send_sms --region $REGION

gcloud functions deploy emailService \
    --runtime python39 --trigger-http --allow-unauthenticated \
    --entry-point send_email --region $REGION

# Deploy Workflow
echo "Deploying Workflow..."
gcloud workflows deploy v2c-workflow --source=infrastructure/workflow.yaml --region $REGION

# Grant IAM permissions
echo "Granting IAM permissions..."
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:$PROJECT_ID@appspot.gserviceaccount.com \
    --role=roles/workflows.invoker

echo "Setup complete! Resources are now ready for use."
