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
Also part of the backend is a NoSQL database, which

![Architecture](architecture_cloud.png)

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

The database is a "NoSQL"-Database build out of the collection "defects" with the documents for the different reports.
An example defect-report document looks like this:

TODO:
```json


```

## Google Cloud

The complete PaaS is hosted on Google Cloud.
While the microservices must be deployed manually, MongoDB is hosted and configured by MongoDB Atlas on Google Cloud.

### Microservices

The microservices are run on Google Cloud.
For startup, first make sure to enter valid host addresses as environment variables in the script `google_cloud_push.sh`.
After that, execute this script and the services will be built and deployed to Google Cloud automatically.

Startup: Execute `google_cloud_push.sh`
1. Database API Image
   1. Builds database API-Image
   2. Pushes the database API Image to Google Cloud
   3. Runs the image and creates the container on Google Cloud with the environment variable for the MongoDB Connection
2. Frontend
   1. Builds frontend out of the Dockerfile with a creation argument (URL)
   2. Pushes the frontend Image to Google Cloud
   3. Runs the image and creates the container on Google Cloud

### Firestore

The database is not outsourced to a "NoSQL" in Firebase on Google Cloud.

To setup the database on Google, the following steps has to be done, based on following [Description](https://firebase.google.com/docs/firestore/quickstart?hl=de)
1. Setup Firestore Database (Name: `(default)` (no extra costs))
2. Setup Development Environment:
   1. Create "Dienstkonto" for the Project
   2. Save the data in a local file and set `export GOOGLE_APPLICATION_CREDENTIALS="KEY_PATH"`
3. Configure everything in the C# Code

### Object Storage

Objects (like images) are stored in the object storage.

To setup the object storage (buckets), the following steps has to be done:
1. Create a "msi-cad-vw-bucket"
