# Deploy the HCL Digital Solutions Keycloak service through Docker Compose

Deploying the service through Docker Compose is arguably the easiest way to get up and running, as the alternative through ([Helm charts](./helm/) bases on the same service, containerized through Docker as well.

## Overview

[Docker Compose](https://docs.docker.com/compose/) is closely related to Docker as it is a tool specifically designed to work with Docker containers. Docker Compose enables the management of multi-container applications using a declarative approach, allowing to define the configuration of multiple containers, networks, and volumes in a single YAML file. This configuration can then be used to orchestrate the deployment and interaction of these containers. In essence, Docker Compose builds upon Docker's capabilities by providing a higher-level abstraction for defining and coordinating complex containerized applications.

In the context of the HCL Digitial Solutions Keycloak service, Docker Compose is helpful as it allows a simple way to incorporate PostgreSQL as the persistence layer as well as customizations and extensions like an HCL branded login theme or a default configuration through volumes.

## Running the service via Docker Compose

Running the HCL DS Keycloak service is as simple as navigating to the [deployment/docker-compose](../../deployment/docker-compose/) directory and running the following command:

```sh
cd deployment/docker-compose

docker-compose up
```

The command starts the Keycloak service in a small configuration. The [docker-compose.yaml](../../deployment/docker-compose/docker-compose.yaml) file as well as the underlying [Dockerfile](../../Dockerfile) contain environment properties to set default and mandatory configuration. E.g., it will set the admin user to be called `admin` with password `admin`. It will also be started in development mode. 

From here, try to access the instance at location [localhost:8080/](localhost:8080) (make sure to use an appropriate FQDN if you have started this on a server). You should see the "Welcome to **Keycloak**" website appearing. 

That's it! Feel free to explore around, look at the [Administration](../administration/) steps or check out more elaborate setups with [Helm charts](./helm/).