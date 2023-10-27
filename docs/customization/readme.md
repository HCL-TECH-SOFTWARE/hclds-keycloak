# Customization

Explore avenues of customization through extension and theming. Discover the realm of custom themes to harmonize the user interface with your brand's identity and preferences.

- [Custom Themes](./custom-themes.md)
- [Custom User Attributes](./custom-user-attributes.md)

As an overview, there are multiple ways to customize the Keycloak service, which can be broken up into
    - User experience – Themes, overall UI makeup and languages/strings
    - Functional extensions and changes – Federation, brokering, theme selection, adding new REST endpoints and more
- Generally, Keycloak expects files in specific formats to be injected into specific directories and aggregates them into the base behavior
    - I.e., a base theme can be provided, and additional themes become available to select in the Admin UI
- Functional changes/extensions are done by injecting jars and leveraging a variety of SPIs
    - Allows extension of authentication, token handling, event listening, role mapping, user federation, vault and more
- Files can be injected through volume mounts or by providing them through custom ‘init containers’ (see [more details](https://artifacthub.io/packages/helm/codecentric/keycloakx#providing-a-custom-theme))
- **Note**: There are many ways of customizing behaviors through base features (adding capabilities, changing flows and more) – see [Server Administration Guide](https://www.keycloak.org/docs/latest/server_admin/) for more details (out of scope for this document)

## Testing customizations

To test customizations, we recommend using the [Docker](../deployment/docker.md) or [Docker Compose](../deployment/docker-compose.md) deployment strategies for rapid deployment and quick iterations. The updates can be injecting into the existing theme or additional custom themes. 

This area will be expanded on in the future with more details and guidance around custom theme creation. 