# Keycloak

This repository contains a [Keycloak](https://www.keycloak.org/) service that is adjusted to be more relevant and aligned with the HCL Digital Solutions (DS) products by adding configuration, an HCL branded login UI, and more. 

Keycloak is a high performance Java-based identity and access management solution. It lets developers add an authentication layer to their applications with minimum effort.

[Overview of Keycloak](https://www.keycloak.org/)

In this repository you will find Keycloak as a reference implementation of an Identity Provider (IdP) that serves as an internal validation tool for our HCL Digital Solutions products. Our primary goal is to provide a hands-on experience with common strategies, configurations, and solutions related to integrating IdPs using the OIDC authentication protocol.

In this repository, you'll find resources and documentation around Keycloak in particular, but also around the OIDC protocol more broadly. It may also help as a resource for understanding and implementing identity and access management. 

Our Keycloak service bases off of Bitnami's Keycloak [image](https://hub.docker.com/r/bitnami/keycloak/) as well as [Helm chart](https://bitnami.com/stack/keycloak/helm) and extends it with some intial configuration to easily get started testing things out with HCL Digital Solutions products like CNX, DX and Leap. It also provides an HCL branded theme that applies our latest design guidelines for login UIs.


## Documentation

This repository includes elaborate [documentation](./docs/) around getting started with this service and with OIDC as a whole. It also provides details on integration scenarios against our products that ultimately aim to simplify the OIDC configuration for them. The documentation also is intended to provide strategies and approaches to solve particular challenges around OIDC set ups and help customers incorporating our products into their own OIDC-based security landscape. 

Note that throughout the documentation, various abbreviations and terms are used that may not be clearly defined at the same location. In case you come across any terminology you are unsure about, check out the [terminology and abbreviations](./docs/getting-started/terms-abbreviations.md) section.


## Contributions and Feedback

Your input holds immense value to us. We welcome contributions, suggestions, and inquiries aimed at refining our documentation, configuration or implementation. Should you seek to extend this resource or require clarification, please let us know through issues, pull requests or directly reaching out to our core contributors (refer to the page [CONTRIBUTING](./CONTRIBUTING.md) for more details). HCL will make every reasonable effort to assist in problem resolution of any issues found in this software.


## Support

This software is provided "AS-IS" without warranty of any kind, expressed or implied.