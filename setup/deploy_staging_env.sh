
VERSION="0.0.1"
PROJECT_ID=msi-cad-vw-staging
BUCKET=msi-cad-vw-staging-bucket
SERVICE_ACCOUNT=msi-cad-vw-staging-account@$PROJECT_ID.iam.gserviceaccount.com

# Set the current project locally
gcloud config set project $PROJECT_ID
gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=./keys/key-msi-cad-vw-staging-account.json

# To update your Application Default Credentials quota project, use the `gcloud auth application-default set-quota-project` command.

# Create defect-management-api
docker build --tag defect-management --file defect-management/Msi.Cad.DefectManagement/Msi.Cad.DefectManagement.Presentation/defectManagement.Dockerfile defect-management/Msi.Cad.DefectManagement       # Build database
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

# docker build --tag mqtt-broker --file mqtt/mqtt_broker.Dockerfile mqtt/   # Build mosquitto
# docker tag eclipse-mosquitto europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/mosquitto:$VERSION
# docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/defect-management:$VERSION
# gcloud run deploy msi-cad-vw-defect-management --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/defect-management:$VERSION \
#     --platform=managed --region=europe-west1 --allow-unauthenticated --port=8080 --memory=1Gi \
#     --set-env-vars MSICAD_Options__ProjectId=$PROJECT_ID \
#     --set-env-vars MSICAD_Options__FileUploadBucket=$BUCKET \
#     --service-account $SERVICE_ACCOUNT


docker system prune -f
