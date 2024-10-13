# Parking Management Cloud Application

This SaaS application was built as part of the "Cloud Application Development" lecture at HTWG Konstanz.
The repositories and sourcecode can be accessed [on GitHub](https://github.com/msi-cad-vw).

## System Architecture

The system's architecture is split into Frontend and Backend, consisting of several microservices.
Also part of the backend is a MongoDB database for persistent data storage.

![Architecture](architecture.png)

Every service is containerized and run in Docker environment.
The underlying operating system is Ubuntu 20.04.

### Frontend Service

The Frontend Service provides the actual website pages that the User may interact with.
It is written using ReactJS.
It can retrieve data from the database by calling the Database Service in the Backend through a REST API.

### Database Service

The Database Service is implemented in C# and .NET 8.0.
Being a kind of "middleware", it contains business logic to save and retrieve data to and from the database while validating it.
For startup, the service is containerized using a Dockerfile and run in the Docker environment.

### Database

MongoDB is used as the database engine for persistent data storage.
Like other services, MongoDB is directly installed to the Docker environment.
This can be done using the official image [provided by Dockerhub](https://hub.docker.com/r/mongodb/mongodb-community-server).