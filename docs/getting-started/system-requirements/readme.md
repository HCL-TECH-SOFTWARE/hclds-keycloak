# System requirements

The Keycloak service has the following system requirements and prerequisites for clients to use it and to deploy the service on servers. The requirements fall into four categories:

- [Kubernetes](#kubernetes) as the orchestration solution for the containerized Keycloak service
- The [Keycloak service](#keycloak-service) itself
- The [database](#databases) leveraged as a persistence layer to the Keycloak service
- [Web browsers](#web-browsers) and their supported versions

## Performance data

HCL tested the following versions and generated the obtained test results on August 18, 2023. The performance data discussed herein is presented as derived under specific operating conditions. Actual results may vary.

## Kubernetes

To use the Keycloak service, your environment must meet the following requirements.

### Kubernetes platform policy

- The Kubernetes platform must be hosted on x86-64 hardware.
- The Kubernetes platform must be officially supported by Helm. See [Kubernetes Distribution Guide](<https://helm.sh/docs/topics/kubernetes_distros/>).

#### Kubernetes platforms tested with the Keycloak service

The following Kubernetes platforms have been tested by HCL:

- Kubernetes versions 1.26 to 1.28 on CentOS and RedHat versions 7 and 8
- [Minikube](https://minikube.sigs.k8s.io/docs/) versions 1.26 to 1.28 in a small-scale setup for continuous deployment and testing on CentOS and RedHat versions 8 and 9

## Keycloak service

The Keycloak service runs in a JVM, specifically on Quarkus. Typically, Keycloak is well optimized and does not require substantial resources to run. As a centralized point for authentication, special consideration here is on request spikes because users often log in at the same time.

The minimum requirements to install and run Keycloak are as follows:

- Can run on any operating system that runs Java
- Java 8 JDK
- zip or gzip and tar
- At least 512M of RAM
- At least 1G of diskspace
- A shared external database like Postgres, MySql, Oracle, etc. Keycloak requires an external shared database if you want to run in a cluster. Please see the database configuration section of this guide for more information.
- Network multicast support on your machine if you want to run in a cluster. Keycloak can be clustered without multicast, but this requires a bunch of configuration changes. Please see the clustering section of this guide for more information.
- On Linux, it is recommended to use /dev/urandom as a source of random data to prevent Keycloak hanging due to lack of available entropy, unless /dev/random usage is mandated by your security policy. To achieve that on Oracle JDK 8 and OpenJDK 8, set the java.security.egd system property on startup to file:/dev/urandom.

**Note**: The data is taken from a since outdated and [redacted Keycloak documentation](https://web.archive.org/web/20221004122424/https://www.keycloak.org/docs/18.0/server_installation/#installation-prerequisites) for Keycloak v18.0. Hence, the above data may be inaccurate but is the best point of reference at the current moment.

### Tested systems and scenarios

In a small-scale setup, such as the preceding Minikube instance, Keycloak, including its dependencies like the PostgreSQL Database runs on an AWS EC2 t2.medium instance. This AWS instance has the following elements: 

- vCPUs: 2 (@2.4GHz)
- RAM (GiB): 4GiB
- Disk space: 10GB

In a medium-scale setup on Kubernetes, we tested advanced setups with multiple replicas and a highly available PostgreSQL database on [AWS EC2 c5.2xlarge](https://aws.amazon.com/ec2/instance-types/c5/) instances. In those tests we ran higher throughput, but still smaller than an enterprise setup would typically handle. These instances have the following elements:

- vCPUs: 8 (@3.0GHz)
- RAM (GiB): 16GiB
- Disk space: 200GB

## Databases

The PostgreSQL database has been validated in combination with the Keycloak service. In a default Helm and Kubernetes setup, a single non-HA instance of PostgreSQL is connected for persistence. An existing PostgreSQL database can be connected through Helm configuration. The documentation also provides an example that shows how an HA PostgreSQL setup can be created and connected to the authentication service.
HCL has tested with both the non-HA [bitnami/postgreql](https://hub.docker.com/r/bitnami/postgresql) and the HA [postgresql-repmgr](https://hub.docker.com/r/bitnami/postgresql-repmgr), both in version 15.3.

## Web browsers

Typically, all modern browsers are supported. The following browsers were tested:

| Browsers | Minimum supported version |
|--------------------|----------------------------|
| Apple Safari | 16.5.1  |
| Google Chrome | 115.0.5790.170 |
| Microsoft Edge | 115.0.1901.203 |
| Mozilla Firefox | 116.0.2 |
