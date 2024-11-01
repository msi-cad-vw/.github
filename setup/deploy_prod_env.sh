#!/bin/bash
VERSION="1.0.7"
PROJECT_ID=msi-cad-vw
BUCKET=msi-cad-vw-bucket
SERVICE_ACCOUNT=msi-cad-vw-objectstorage@msi-cad-vw.iam.gserviceaccount.com

# Set the current project locally
gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=./keys/key-msi-cad-vw-prod-account.json
gcloud config set project $PROJECT_ID

# Create database-api
docker build --tag cloud-database --file database/Msi.Cad.Database/Msi.Cad.Database/database.Dockerfile database/Msi.Cad.Database       # Build database
docker tag cloud-database:latest europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/cloud-database:$VERSION
docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/cloud-database:$VERSION
gcloud run deploy msi-cad-vw-database --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/cloud-database:$VERSION \
    --platform=managed --region=europe-west1 --allow-unauthenticated --port=8080 --memory=1Gi \
    --set-env-vars MSICAD_Options__ProjectId=$PROJECT_ID \
    --set-env-vars MSICAD_Options__FileUploadBucket=$BUCKET \
    --service-account $SERVICE_ACCOUNT

REACT_APP_SERVER_ADDRESS=$(gcloud run services list --platform managed | awk 'NR==2 {print $4}')
echo $REACT_APP_SERVER_ADDRESS

# docker build --tag cloud-frontend --build-arg REACT_APP_SERVER_ADDRESS $REACT_APP_SERVER_ADDRESS --file frontend-main/frontend_with_build.Dockerfile frontend-main/
# docker tag cloud-frontend:latest europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/cloud-frontend:$VERSION
# docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/cloud-frontend:$VERSION
# gcloud run deploy msi-cad-vw-frontend --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/cloud-frontend:$VERSION --platform=managed --region=europe-west1 --allow-unauthenticated --port=80 --memory=1Gi

docker system prune -f