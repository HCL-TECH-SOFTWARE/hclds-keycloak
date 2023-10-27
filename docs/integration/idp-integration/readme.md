# Integrating with IdP

This section provides two examples of how an IdP communicating through either OIDC or SAML could be configured against Keycloak to carry forward the authentication towards applications serving as a RP towards Keycloak. Both samples leverage Microsoft Azure Active Directory for their configuration.

This documentation is very focused on the HCL DS Keycloak service and setting it up as an identity broker, but may be applicable to other IdPs as well.

- [Setting up workflow between Azure AD (IDP) and Keycloak (SP) using OIDC](./azure-oidc-integration.md)
- [Setting up workflow between Azure AD (IDP) and Keycloak (SP) using SAML](./azure-saml-integration.md)