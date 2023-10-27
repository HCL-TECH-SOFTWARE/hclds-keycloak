# Deployment

Understand the road to a smooth deployment of Keycloak within your environment. Begin by preparing your environment to create a stable foundation. Our guide covers environment setup and continues with deployment using Docker containers. For Kubernetes users, our documentation dives into deploying through Helm charts, simplifying the process and ensuring consistency. When issues arise or disengagement is necessary, you will also find an uninstallation guide and troubleshooting solutions.

## Helm based deployments

The provided deployment instructions and details heavily focus on Helm based deployments to Kubernetes environments. Please refer to the following sections for specific parts around the deployment:

- [Helm and Keycloak chart overview](./helm)
- [Installation](./helm/install.md)
- [Configuration Parameters](./helm/configuration-properties.md)
- [Additional configuration and installation details](./helm/additional-configuration-details.md)
- [Uninstall](./helm/uninstall.md)
- [Troubleshooting](./helm/troubleshooting.md)


## Alternative deployment modes

Although Helm based deployments are recommended, they have requirements towards Kubernetes and thus additional system resources. They are also more targeted towards longer-running instances that are used to e.g., evaluate OIDC configuration of HCL Digital Solutions (DS) products against.

Alternatively, you can also get up and running quickly through [Docker](./docker.md) or [Docker Compose](./docker-compose.md), which provide a simplified deployment that is more targeted towards quick tests, iterative changes and review and other small and more pointed use-cases. You can find more information on both by clicking on their respective links and sections.