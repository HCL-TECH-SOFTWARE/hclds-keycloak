# Deploy the HCL Digital Solutions Keycloak service through Docker

Deploying the service through Docker is arguably the easiest way to get up and running, as the alternatives ([Helm charts](./helm/) and [Docker Compose](./docker-compose.md)) both base on the same service, containerized through Docker as well.

## Build the image for the service

First, build the image through the following command:

```sh
docker build -f Dockerfile --tag hclds-keycloak .
```

**Note** - Feel free to use any other tag name here, or bundle some of the available [Configuration properties](./configuration.md#overview-of-variables). Also note that you need to have a docker daemon / the docker CLI running. When building locally, it's typically easiest to use [Docker Desktop](https://www.docker.com/products/docker-desktop/).

You should see the image building and eventually finishing successfully:

```sh
[+] Building 9.8s (11/11) FINISHED
...
 => => naming to docker.io/library/hclds-keycloak 
```

You can confirm your image has been created by checking the image tag via the following command:

```sh
docker image ls | grep keycloak
hclds-keycloak                                                                  latest                  d2a806a74638   2 minutes ago   642MB
```

## Running the service via Docker

From here, you can run the created image via the following command:

```sh
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KEYCLOAK_DATABASE_VENDOR=dev-file hclds-keycloak:develop start-dev
```

The command starts the Keycloak service in a minimum configuration. The environment properties listed will set the admin user to be called `admin` with password `admin` and it will use a file-based database to have no dependency to any co-located database. It will also be started in development mode. 

From here, try to access the instance at location [localhost:8080/](localhost:8080) (make sure to use an appropriate FQDN if you have started this on a server). You should see the "Welcome to **Keycloak**" website appearing.

That's it! Feel free to explore around, look at the [Administration](../administration/) steps or check out more elaborate setups with [Helm charts](./helm/).