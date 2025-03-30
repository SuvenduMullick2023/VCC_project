🌟 Explanation of Components
1️⃣ Infrastructure Management
setup_gcp_resources.sh → Automates GCP resource creation.

api_gateway.yaml → Defines API Gateway routes.

workflow.yaml → Defines Workflows for function orchestration.

cloudbuild.yaml → CI/CD pipeline.

2️⃣ Microservices
API Handler (api_handler/main.py) → Exposes an API endpoint.

SMS Service (sms_service/sms.py) → Sends SMS notifications via Twilio.

Email Service (email_service/email.py) → Sends emails via SendGrid.

3️⃣ Deployment & Testing
deploy_functions.sh → Deploys Cloud Functions.

test_endpoints.sh → Tests API and services.

Workspace Directory Structure

gcp_v2c_project/
│── infrastructure/                  # IaC scripts for provisioning resources
│   ├── setup_gcp_resources.sh       # Shell script to automate resource creation
│   ├── api_gateway.yaml             # API Gateway OpenAPI configuration
│   ├── workflow.yaml                 # GCP Workflows YAML configuration
│   ├── cloudbuild.yaml               # Cloud Build CI/CD Pipeline
│
│── services/                         # Microservices directory
│   ├── api_handler/                  # API Gateway & HTTP trigger service
│   │   ├── main.py                    # Flask app for API Gateway
│   │   ├── requirements.txt           # Dependencies for API handler
│   │   ├── Dockerfile                 # Optional: For Cloud Run deployment
│
│   ├── sms_service/                   # SMS Notification Microservice
│   │   ├── sms.py                      # Twilio integration for sending SMS
│   │   ├── requirements.txt            # Dependencies
│
│   ├── email_service/                 # Email Notification Microservice
│   │   ├── email.py                    # SendGrid email service
│   │   ├── requirements.txt            # Dependencies
│
│── scripts/                           # Utility and Deployment Scripts
│   ├── deploy_functions.sh             # Script to deploy cloud functions
│   ├── test_endpoints.sh               # Script to test deployed APIs
│
│── .env                               # Environment variables (ignored in Git)
│── README.md                          # Project Documentation
