# Documentation

Welcome to our documentation for the HCL Digital Solutions Keycloak reference implementation. The documentation aims to provide a comprehensive guide tailored to assist users in familiarizing, deploying, administrating, and customizing Keycloak as a sample identity and access management solution. Whether you are a novice embarking on your first steps or an adept user seeking integration and customization insights, this documentation addresses your requirements.

## Table of Contents

### [Getting Started](./getting-started)

This section serves as an introductory overview of Keycloak's core concepts and features. Gain an understanding of its value proposition within the sphere of identity management. Proceed by understanding the product and architecture and the role of the OpenID Connect (OIDC) protocol within as a modern authentication strategy. This section also provides an outlook for the necessary system requirements to get it up and running.

- [Service Overview](./getting-started/service-overview/)
- [OpenID Connect](./getting-started/oidc/) and [JSON Web Tokens](./getting-started/oidc/jwt-tokens.md)
- [System requirements](./getting-started/system-requirements/)


### [Deployment](./deployment)

Understand the road to a smooth deployment of Keycloak within your environment. Begin by preparing your environment to create a stable foundation. Our guide covers environment setup and continues with deployment using Docker containers. For Kubernetes users, our documentation dives into deploying through Helm charts, simplifying the process and ensuring consistency. When issues arise or disengagement is necessary, you will also find an uninstallation guide and troubleshooting solutions.

#### Helm based deployments

The provided deployment instructions and details heavily focus on Helm based deployments to Kubernetes environments. Please refer to the following sections for specific parts around the deployment:

- [Helm and Keycloak chart overview](./deployment/helm)
- [Installation](./deployment/helm/install.md)
- [Configuration parameters](./deployment/helm/configuration-properties.md)
- [Additional configuration and installation details](./deployment/helm/additional-configuration-details.md)
- [Uninstall](./deployment/helm/uninstall.md)
- [Troubleshooting](./deployment/helm/troubleshooting.md)

#### Alternative deployment modes

Although Helm based deployments are recommended, they have requirements towards Kubernetes and thus additional system resources. They are also more targeted towards longer-running instances that are used to e.g., evaluate OIDC configuration of HCL Digital Solutions (DS) products against.

Alternatively, you can also get up and running quickly through [Docker](./deployment/docker.md) or [Docker Compose](./deployment/docker-compose.md), which provide a simplified deployment that is more targeted towards quick tests, iterative changes and review and other small and more pointed use-cases. You can find more information on both by clicking on their respective links and sections.


### [Administration](./administration/)

The Administration and Configuration section provides insights to proficiently administer and configure Keycloak. In its core, it provides an overview of steps you might want to explore and refers to the extensive documentation the Keycloak team themselves publish. 

- [Server Administration Guide](./administration/readme.md)


### [Integration](./integration/)

This section provides instructions for seamlessly integrating our HCL Digital Solutions products into Keycloak using the OIDC protocol. Additionally, you can find details on turning Keycloak into an identity broker by configuring other identity providers against it. Our step-by-step instructions lay out the setup process and touch on available options. The documentation also serves as a exploratory area for additional ways of configuring your products and sample scenarios to enable particular use cases or product capabilities. Once thoroughly validated and refined, they build the basis for expanding the respective official product documentation.

- [Integrating with HCL Software](./integration/ds-integration/)
- [Integrating with IdPs](./integration/idp-integration/)


### [Customization](./customization/)

Explore avenues of customization through extension and theming. Discover the realm of custom themes to harmonize the user interface with your brand's identity and preferences.

- [Custom Themes](./customization/custom-themes.md)
- [Custom User Attributes](./customization/custom-user-attributes.md)


### [API Documentation](./api-documentation/)

Learn about the APIs that underpin Keycloak's functionality. Familiarize yourself with the different API categories and gain an overview of the available methods, their functional scope and how to leverage them.