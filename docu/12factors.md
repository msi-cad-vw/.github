# 12 Factors

This is the documentation of the Parking Management PaaS to follow the [12 factors](https://12factor.net/) for good SaaS.

## I. Codebase

> One codebase tracked in revision control, many deploys

We use the Multi-Repo approach for the organization of source code repositories.
Each repository serves a single microservice.
Since all repositories are located at [GitHub](https://github.com/msi-cad-vw), they are using Git as their Version Control System (VCS).  
As of yet, deployment is done manually and, thus, not with every new commit.
When introducing CI/CD-pipelines, the deployment frequency will increase.

## II. Dependencies

> Explicitly declare and isolate dependencies

Both, the frontend and backend service, use their respective framework's package manager.
In the frontend service, using ReactJS as the framework, packages are managed by `npm`.
With .NET as the executing framework for the backend service, packages are provided by `Nuget`.  
In both approaches, the packages are referenced from an external source with name and version numbeer and only loaded upon build.
No code from the package is included in the source code of the microservices.

## III. Config

> Store config in the environment

### Frontend Service

The Frontend Service is running in a mostly environment-agnostic configuration.
Single settings, like the backend host address, can be changed at runtime using environment variables.

### Backend Service

The Backend Service uses a mixture of different configuration possibilities.
All these build upon each other and overwrite the values, if needed.

1. The general configuration is done through the `appsettings.json` file.
It contains generally valid settings like the format of logging messages.  
The `json` file is versioned in the Git repository itself.

2. An environment-specific configuration can be done using the `appsettings.{Environment}.json` file, where `{Environment}` is the name of the environment, i. e. `Staging`.  
This `json` file is also contained within the Git repository.

3. Container-specific configuration can be done at runtime through environment variables. Values set like this will overwrite the default values from the `json` configuration.

## IV. Backing services

> Treat backing services as attached resources

By using a Microservice Architecture, all services are set up for one specific purpose.
Each service communicates either over HTTP or gRPC (for Google Cloud Services).

## V. Build, release, run

> Strictly separate build and run stages

Having two strictly separate executing environments, namely `Staging` and `Production`, is the baseline for these stages.
Currently, building and releasing is done completely manually.
There are no pipelines, neither for the Frontend nor the Backend Service.  
When automating the deployment in the future, there must be a strict separation of building the source code into an artifact and releasing this artifact onto the target environment.

## VI. Processes

> Execute the app as one or more stateless processes

Each service is set up as a stateless, reproducible process.
All persistent data is stored in a database, namely `Google Firestore`.
Persistent file storage is set up in `Google Object Storage`.
This way, every microservice can access the data or files through a network interface and does not need to store any data locally.

## VII. Port binding

> Export services via port binding

## VIII. Concurrency

> Scale out via the process model

Again, having a microservice architecture, sets a strong baseline regarding Concurrency and the Process model.
Each service can be duplicated effortlessly, if needed.
This way, scenarios with increased load on the system, can easily be dealt with by duplicating the problematic service(s).
With our PaaS, Google Cloud Platform serves as the process manager and can automatically boot up new services when a heavier-than-normal load is detected.

## IX. Disposability

> Maximize robustness with fast startup and graceful shutdown

Each service serves a purpose, which might not be too large.
Thus, all services are implemented in a very lightweight manner, focusing on the most important features only.
This minimizes startup time, while, at the same time, recuding the load on any individual microservice, which, in turn, provides a graceful shutdown.

## X. Dev/prod parity

> Keep development, staging, and production as similar as possible

Currently, the staging environment also serves as the development system.
Any changes, made in code, are directly published to it.
The frequency of updating the production system varies greatly, because, as of now, releases are done manually.
When introducing CI/CD pipelines, this step can further be automated to always have regular releases.

## XI. Logs

> Treat logs as event streams

Using Google Cloud Platform as the execution environment, all logging messages are collected automatically and treated as a kind of event stream.
These can be viewed for each container seperately and are ordered by time and date.  
The collection and storing of these logging messages is handled by Google Cloud Platform.
A service only logs a message through its built-in logging mechanism and the rest is handled by Google Cloud Platform.

## XII. Admin processes

> Run admin/management tasks as one-off processes

Any changes to the database are handled through code in the Backend Service.
A manual interception by using, for example, the web interface, is not permitted.
Likewise, access to any administrative features is restricted to certain people only.
