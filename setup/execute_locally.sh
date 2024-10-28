#!/bin/bash

REACT_APP_SERVER_ADDRESS="https://msi-cad-vw-database-103924362067.europe-west1.run.app"
VERSION="1.0.7"

# Build and Run Database-API
docker build --tag cloud-database --file database/Msi.Cad.Database/Msi.Cad.Database/database.Dockerfile database/Msi.Cad.Database       # Build database
docker run --volume /home/maren/.config/gcloud:/var/lib --env GOOGLE_APPLICATION_CREDENTIALS=/var/lib/application_default_credentials.json --env GOOGLE_SERVICE_ACCOUNT_SECRET=/var/lib/msi-cad-vw-private-key.json  -p 8080:8080 cloud-database

# Create frontend
# if the URLs changes we can read the URL of the database and write it into the REACT_APP_SERVER_ADDRESS variable
# e.g. execute gcloud run services describe msi-cad-vw-database and select the URL

# Build the docker image of the frontend
docker build --tag cloud-frontend --build-arg REACT_APP_SERVER_ADDRESS=$REACT_APP_SERVER_ADDRESS --file frontend-main/frontend_with_build.Dockerfile frontend-main/
# docker build --tag cloud-frontend --file frontend-main/frontend.Dockerfile frontend-main/         # Fast execute with existing build-file but without env
docker run -d -p 80:80 cloud-frontend                                                             # Execute locally