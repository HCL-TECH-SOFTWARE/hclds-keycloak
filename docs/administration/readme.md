# Server Administration Guide

This section provides insights to proficiently administer and configure Keycloak. In its core, it provides an overview of steps you might want to explore and refers to the extensive documentation the Keycloak team themselves publish. 

For the scope of this document we will briefly explain commonly used topics around server administration and refer to public documentation provided by [Keycloak](https://www.keycloak.org).

For detailed documentation please refer to [Server Administration Guide](https://www.keycloak.org/docs/latest/server_admin/index.html).

## Creating the first administrator

After installing Keycloak, you need an administrator account that can act as a super admin with full permissions to manage Keycloak. With this account, you can log in to the Keycloak Admin Console where you create realms and users and register applications that are secured by Keycloak.

We manage administrator account creation through our helm charts.

## Configuring realms

Once you have an administrative account for the Admin Console, you can configure realms. A realm is a space where you manage objects, including users, applications, roles, and groups. A user belongs to and logs into a realm. One Keycloak deployment can define, store, and manage as many realms as there is space for in the database.

For further information please refer to [Configuring realms](https://www.keycloak.org/docs/latest/server_admin/index.html#configuring-realms).

## Using external storage

Organizations can have databases containing information, passwords, and other credentials. Typically, you cannot migrate existing data storage to a Keycloak deployment so Keycloak can federate existing external user databases. Keycloak supports LDAP and Active Directory, but you can also code extensions for any custom user database by using the Keycloak User Storage SPI.

For further information please refer to [Using external storage](https://www.keycloak.org/docs/latest/server_admin/index.html#_user-storage-federation).

## Integrating identity providers

An Identity Broker is an intermediary service connecting service providers with identity providers. The identity broker creates a relationship with an external identity provider to use the provider’s identities to access the internal services the service provider exposes.

From a user perspective, identity brokers provide a user-centric, centralized way to manage identities for security domains and realms. You can link an account with one or more identities from identity providers or create an account based on the identity information from them.

For further information please refer to [Integrating identity providers](https://www.keycloak.org/docs/latest/server_admin/index.html#_identity_broker).

## Managing OpenID Connect and SAML Clients

Clients are entities that can request authentication of a user. Clients come in two forms. The first type of client is an application that wants to participate in single-sign-on. These clients just want Keycloak to provide security for them. The other type of client is one that is requesting an access token so that it can invoke other services on behalf of the authenticated user. This section discusses various aspects around configuring clients and various ways to do it.

For further information please refer to [Managing OpenID Connect and SAML Clients](https://www.keycloak.org/docs/latest/server_admin/index.html#assembly-managing-clients_server_administration_guide).

## Configuring auditing to track events

Keycloak includes a suite of auditing capabilities. You can record every login and administrator action and review those actions in the Admin Console. Keycloak also includes a Listener SPI that listens for events and can trigger actions. Examples of built-in listeners include log files and sending emails if an event occurs.

For further information please refer to [Configuring auditing to track events](https://www.keycloak.org/docs/latest/server_admin/index.html#configuring-auditing-to-track-events).

## Best practices for Keycloak setups

There are some best practices that can be following when setting up a Keycloak service in extended test environments that have additional requirements to scalability or security:
- [Realm Keys and Key Rotation](./best-practices/rotating-keys.md)
- [Scaling Keycloak](./best-practices/scaling.md)
- [Resource Management for Pods and Containers](./best-practices/resources.md)