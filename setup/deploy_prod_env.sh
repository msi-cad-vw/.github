#!/bin/bash
VERSION="1.0.7"
PROJECT_ID=msi-cad-vw
BUCKET=msi-cad-vw-bucket
SERVICE_ACCOUNT=msi-cad-vw-objectstorage@msi-cad-vw.iam.gserviceaccount.com

# Set the current project locally
gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=./keys/key-msi-cad-vw-prod-account.json
gcloud config set project $PROJECT_ID

# Create database-api
docker build --tag defect-management --file defect-managment/Msi.Cad.Database/Msi.Cad.Database/database.Dockerfile defect-management/Msi.Cad.Database       # Build database
docker tag defect-management:latest europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/defect-management:$VERSION
docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/defect-management:$VERSION
gcloud run deploy msi-cad-vw-defect-management --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/defect-management:$VERSION \
    --platform=managed --region=europe-west1 --allow-unauthenticated --port=8080 --memory=1Gi \
    --set-env-vars MSICAD_Options__ProjectId=$PROJECT_ID \
    --set-env-vars MSICAD_Options__FileUploadBucket=$BUCKET \
    --service-account $SERVICE_ACCOUNT

REACT_APP_SERVER_ADDRESS=$(gcloud run services list --platform managed | awk 'NR==4 {print $4}')
echo $REACT_APP_SERVER_ADDRESS

# docker build --tag frontend --build-arg REACT_APP_SERVER_ADDRESS=$REACT_APP_SERVER_ADDRESS REACT_APP_AUTH_API_KEY="AIzaSyBsJcpLx9_-k411a4uNKw1epe-yeZU0HP8" REACT_APP_AUTH_DOMAIN="msi-cad-vw-staging.firebaseapp.com" --file frontend-main/frontend_with_build.Dockerfile frontend-main/
docker build --tag frontend --file frontend/frontend.Dockerfile frontend/
docker tag frontend:latest europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/frontend:$VERSION
docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/frontend:$VERSION
gcloud run deploy msi-cad-vw-frontend --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/frontend:$VERSION --platform=managed --region=europe-west1 --allow-unauthenticated --port=80 --memory=1Gi

docker system prune -f
