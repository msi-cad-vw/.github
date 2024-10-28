#!/bin/bash
PROJECT_ID=msi-cad-vw
LOCATION=europe-west1

IMAGE_VERSION=latest
DATABASE_SERVICE_NAME=msi-cad-vw-database
DATABASE_IMAGE_PATH=europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-database

BUCKET_NAME="msi-cad-vw-bucket"

SECRET_VERSION=latest
SECRET_NAME=msi-cad-vw-secret
SECRET_ENV_VARIABLE=GOOGLE_SERVICE_ACCOUNT_SECRET
VOLUME_SECRET_PATH=msi-cad-vw-secret

# Install Google Cloud
echo "WARNING: This is not tested!!!!!!"
echo "Prequeries: Installed gcloud"

# Setup Docker Run Environment
gcloud services enable artifactregistry.googleapis.com
gcloud artifacts repositories create docker-repo --repository-format=docker --location=$LOCATION --description="Docker repository for msi-cad-vw"
gcloud auth configure-docker europe-west1-docker.pkg.dev
gcloud services enable run.googleapis.com
  
# Configure Firestore
gcloud auth application-default login
export GOOGLE_APPLICATION_CREDENTIALS="KEY_PATH"

echo >> Install Firestore in Console: https://console.cloud.google.com/firestore
sleep 5

# Configure Bucket
gcloud storage buckets create gs://$BUCKET_NAME \
    --project=$PROJECT_ID
    --default-storage-class=STANDARD \
    --location=$LOCATION \

# Handle Secret
gcloud secrets create $SECRET_NAME --replication-policy="automatic"

# Add Secret as a volume
gcloud run deploy $DATABASE_SERVICE_NAME \
    --image=$DATABASE_IMAGE_PATH:$IMAGE_VERSION \
    --platform=managed --region=$LOCATION --allow-unauthenticated --port=8080 --memory=1Gi \
    --update-secrets=$VOLUME_SECRET_PATH=$SECRET_NAME:$SECRET_VERSION

# Add Secret-Volume as an environment variable
gcloud run deploy $DATABASE_SERVICE_NAME \
    --image $DATABASE_IMAGE_PATH \
    --update-secrets=$SECRET_ENV_VARIABLE=$SECRET_NAME:$SECRET_VERSION