# Parking Management Cloud Application

This PaaS application was built as part of the lecture "Cloud Application Development" at HTWG Konstanz.
A demo version is available [on Google Cloud](https://msi-cad-vw-frontend-103924362067.europe-west1.run.app).
The repositories and sourcecode can be accessed [on GitHub](https://github.com/msi-cad-vw).  
Students involved in the development:

* [Maren Franke](mailto:ma452fra@htwg-konstanz.de)
* [Elisha Leoncio](mailto:el871leo@htwg-konstanz.de)
* [Nico Riedlinger](mailto:ni911rie@htwg-konstanz.de)

## System Architecture

The system's architecture is split into Frontend and Backend, consisting of several microservices.
Also part of the backend is a MongoDB database for persistent data storage.

![Architecture](architecture.png)

Every service is containerized and run in Docker environment.
The underlying operating system is Ubuntu 22.04.

### Frontend Service

The Frontend Service provides the actual website pages that the User may interact with.
It is written using ReactJS and can retrieve data from the database by calling the Database Service in the Backend through a REST API.
For ease of use, the Frontend Service is containerized in a Docker container.
It is hosted by an nginx-server.

### Database Service

The Database Service is implemented in C# and .NET 8.0.
Being a kind of "middleware", it contains business logic to save and retrieve data to and from the database while validating it.
For startup, the service is containerized using a Dockerfile and run in the Docker environment.

### Database

MongoDB is used as the database engine for persistent data storage.
Like other services, MongoDB is directly installed to the Docker environment.
This can be done using the official image [provided by Dockerhub](https://hub.docker.com/r/mongodb/mongodb-community-server).

## Google Cloud

The complete PaaS is hosted on Google Cloud.
While the microservices must be deployed manually, MongoDB is hosted and configured by MongoDB Atlas on Google Cloud.

### Microservices

The microservices are run on Google Cloud.
For startup, first make sure to enter valid host addresses as environment variables in the script `google_cloud_push.sh`.
After that, execute this script and the services will be built and deployed to Google Cloud automatically.

1. Database API Image
   1. Builds database API-Image
   2. Pushes the database API Image to Google Cloud
   3. Runs the image and creates the container on Google Cloud with the environment variable for the MongoDB Connection
2. Frontend
   1. Builds frontend out of the Dockerfile with a creation argument (URL)
   2. Pushes the frontend Image to Google Cloud
   3. Runs the image and creates the container on Google Cloud

### MongoDB

The Database is hosted by MongoDB Atlas (MongoDB Cloud), deployed in Google Cloud.

1. Setup a MongoDB by following the official [Script](https://www.mongodb.com/resources/products/platform/mongodb-on-google-cloud)
2. Add a database user
3. Create a Database (i. e. "Parking") and a Collection (i. e. "defects")
4. Save the connection string and use it for possible connections
5. Allow IP-Address(es) (e. g. 0.0.0.0/0 for all IPs or enter a specific IP-Address)

Little Helpers:
- Check services: `gcloud run services describe msi-cad-vw-database`

## Local Setup 

With the `docker-compose.yml` file, you can easily start the application on a local machine. Therefore you have to do the following steps:
1. Create a new folder (e.g. `Cloud`)
2. Clone all repositories into this folder (`database`, `frontend-main` and `.github`)
3. Copy the `docker-compose.yml` out of the `.github/setup` folder into the root folder (in our example `Cloud`): `cp .github/setup/docker_compose.yml .`
4. Build the frontend-application (for further information check the `README.md` in `frontend-main`)
5. Execute `docker compose up --build -d` and wait
6. (optional) Copy the `restart.sh` out of the `.github/setup` and make the restart of the system really easy
