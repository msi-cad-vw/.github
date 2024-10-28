#!/bin/bash
REACT_APP_SERVER_ADDRESS="https://msi-cad-vw-database-103924362067.europe-west1.run.app"
VERSION="1.0.7"

# Create database-api
docker build --tag cloud-database --file database/Msi.Cad.Database/Msi.Cad.Database/database.Dockerfile database/Msi.Cad.Database       # Build database
docker tag cloud-database:latest europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-database:$VERSION
docker push europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-database:$VERSION
gcloud run deploy msi-cad-vw-database --image=europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-database:$VERSION --platform=managed --region=europe-west1 --allow-unauthenticated --port=8080 --memory=1Gi

# Create frontend
# if the URLs changes we can read the URL of the database and write it into the REACT_APP_SERVER_ADDRESS variable
# e.g. execute gcloud run services describe msi-cad-vw-database and select the URL

docker build --tag cloud-frontend --build-arg REACT_APP_SERVER_ADDRESS=$REACT_APP_SERVER_ADDRESS --file frontend-main/frontend_with_build.Dockerfile frontend-main/
docker tag cloud-frontend:latest europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-frontend:$VERSION
docker push europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-frontend:$VERSION
gcloud run deploy msi-cad-vw-frontend --image=europe-west1-docker.pkg.dev/msi-cad-vw/docker-repo/cloud-frontend:$VERSION --platform=managed --region=europe-west1 --allow-unauthenticated --port=80 --memory=1Gi
