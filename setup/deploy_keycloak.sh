# google cloud project settings
PROJECT_ID=msi-cad-vw-parking
SERVICE_ACCOUNT=msi-cad-vw-parking@$PROJECT_ID.iam.gserviceaccount.com
# SERVICE_ACCOUNT=cr-deploy@msi-cad-vw-parking.iam.gserviceaccount.com 

# configure keycloak
KEYCLOAK_VERSION=26.0

# set google cloud project
gcloud config set project $PROJECT_ID
gcloud auth activate-service-account $SERVICE_ACCOUNT --key-file=./keys/msi-cad-vw-parking-e0dfd559021f.json

# pull keycloak image
#docker pull keycloak/keycloak:$KEYCLOAK_VERSION
#docker tag keycloak/keycloak:$KEYCLOAK_VERSION europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/keycloak:$KEYCLOAK_VERSION
#docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/keycloak:$KEYCLOAK_VERSION
#gcloud run deploy msi-cad-vw-keycloak --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/keycloak:$KEYCLOAK_VERSION \
#    --platform=managed \
#	--region=europe-west1 \
#	--port=8080 \
#	--memory=1Gi \
#	--service-account $SERVICE_ACCOUNT


docker build . --tag msi-cad-vw-keycloak-cr --file github/setup/keycloak.Dockerfile
docker tag msi-cad-vw-keycloak-cr:latest europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/keycloak-cr:latest
docker push europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/keycloak-cr:latest

# use argument --update-env-vars to create a temporary admin account for first login
# --update-env-vars=KC_BOOTSTRAP_ADMIN_USERNAME=XXX,KC_BOOTSTRAP_ADMIN_PASSWORD=XXX
gcloud run deploy msi-cad-vw-keycloak --image=europe-west1-docker.pkg.dev/$PROJECT_ID/docker-repo/keycloak-cr:latest \
    --platform=managed \
	--region=europe-west1 \
	--port=8080 \
	--memory=1Gi \
	--service-account $SERVICE_ACCOUNT

# Notes of Maren:
# docker build . --tag keycloak --file keycloak.Dockerfile
# docker tag keycloak:latest europe-west1-docker.pkg.dev/msi-cad-vw-parkspace/docker-repo/keycloak:latest
# docker push europe-west1-docker.pkg.dev/msi-cad-vw-parkspace/docker-repo/keycloak:latest
