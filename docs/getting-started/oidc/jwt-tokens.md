# JWT token

JSON Web Token (JWT) is an open standard that defines a compact and self-contained way for securely transmitting information between parties. In the context of OpenID Connect (OIDC), JWT plays a pivotal role in facilitating secure authentication and authorization.

Tokens are encoded as compact URL-safe strings and consist of three parts: 
- A header,
- A payload, 
- A signature.

 The header typically includes information about the token's type and the cryptographic algorithm used for the signature. The payload contains claims, which are statements about the user or application and additional metadata. These claims can include user identity, authorization scopes, expiration time, and more.

OIDC uses JWTs to achieve secure identity verification and single sign-on (SSO) capabilities. When a user attempts to access a protected resource, the identity provider (IdP) issues a token upon successful authentication. This token is then presented to the resource server, which can verify the token's authenticity by using the signature and then extracting relevant information from the payload.

One of the core benefits of the tokens in OIDC is that they're self-contained. This means that the token carries all the required information for making present authorization decisions, reducing the need for frequent communication between the resource server and the identity provider. Additionally, the tokens can be signed and optionally encrypted, ensuring data integrity and confidentiality throughout the authentication process.

In summary, JWT is a fundamental element of the OIDC framework, facilitating secure authentication and authorization across applications. Understanding the structure and principles of JWT tokens is essential for developers, administrators, and security specialists working with OIDC-based authentication systems. This document focuses on the requirements of JWT tokens within the context of OIDC authentication and the HCL Digital Solutions products and can serve as a reference when you enable them for and manage them through identity solutions.

## Token types

There are three different types of JWT tokens used in the OIDC flow. They all adhere to the general structure and specification of JWT tokens and are differentiated based on the `typ` JWT token claim. The types are outlined below:

1. **ID Token**: This token carries user identity information, providing details about the authenticated user. It's used for single sign-on (SSO) and to verify the user's identity to both the relying party (client application) and the identity provider.
1. **Access Token**: This token is also known as a **bearer** token and authorizes the client application to access resources on behalf of the user. It includes the scopes and permissions granted to the client, allowing it to request resources from resource servers without requiring the user to authenticate again.
1. **Refresh Token**: The refresh token is a long-lived token used to obtain new access and ID tokens when the original ones expire. Refresh tokens enhance security by reducing the exposure of access tokens and user credentials. 

In a typical setup based on general guidelines, the ID and access tokens are purposefully very short lived. IDs are valid for only a few minutes, and access tokens are valid between a few minutes and hours. IDs and access tokens have limited time because these credentials might allow impersonation and access to the client application. To avoid having to constantly log in, the refresh token permits the renewal of IDs and access tokens but requires the IdP for revalidation. This scheme provides an added layer of security.


## JWT token claims

The following table lists claim names that are reserved for JWT token claims. These claims are reserved for specific uses and interpreted those way by OIDC applications. For a full list, including their reference and specifications, see the [JSON Web Token Claims](https://www.iana.org/assignments/jwt/jwt.xhtml) list by IANA. The names listed here pertain to what the HCL DS Keycloak reference implementation typically uses. Keycloak's set of names is flexible so this list mostly applies to a default set.

| Claim name | Description |
|--------------------|----------------------------|
| `iss` | **Issuer:-** This claim identifies the entity that issued the token. It's crucial for verifying the source and authenticity of the token during validation. |
| `sub` | **Subject:-** The subject claim provides information about the subject of the token, which is often the user or the entity associated with the token. It offers contextual details for various authorization decisions |
| `aud` | **Audience:-** This claim specifies the intended recipients or audiences for the token. It ensures that tokens are only accepted by the specified recipients, enhancing security. |
| `exp` | **Expiration time:-** The expiration time claim defines time after which the token rejected. By setting an expiration time, the token's window of usability is limited, minimizing the risk of misuse. |
| `nbf` | **Not before:-** This claim establishes the earliest time when the token is valid. The restriction helps prevent tokens from being is used before it is meant to be active. |
| `iat` | **Issued at:-** The issued-at claim indicates the time when the token was issued. This information can be useful for managing token validity and assessing how long a token has been valid. |
| `jti` | **JWT ID:-** Providing a unique identifier for the token, this claim helps prevent token replay attacks, where an attacker reuses a token to gain unauthorized access. |
| `typ` | **Type:-** The token type claim specifies that the token is of the JWT type. It informs processing mechanisms about the token's format. In OIDC, this can be a `Bearer`, `ID` or `Refresh` type (see [the preceding types](#jwt-token-types)). |
| `name` | **Name:-** This claim provides the user's full name, offering human-readable identification information. |
| `given_name` | **Given name:-** This claim offers the user's given name, enhancing personalized interactions. |
| `family_name` | **Family name:-** This claim presents the user's family name, which is also useful for personalized interactions and identification. |
| `preferred_username` | **Preferred user name:-** This claims presents the user's preferred user name or handle. |
| `email` | **Email:-** This claim presents the user's email address, facilitating communication and identity verification. |
| `email_verified` | **Email verified:-** This claim indicates whether the user's email address has been verified. This property enhances the reliability of user information, because a verified email suggests that the user has confirmed their identity and ownership of the email address. |
| `azp` | **Authorized party:-** This claim contains the client ID that was authorized to use the token. This claim helps verify the client-application that is granted access. |
| `auth_time` | **Authentication time:-** This claim indicates the time when the user was last authenticated. This claim can be useful for assessing session freshness and managing re-authentication requirements. |
| `at_hash` | **Access token hash:-** This claim is calculated from the access token and can be used to mitigate some security vulnerabilities related to token leakage. It is added to the identity token. |
| `acr` | **Authentication context class reference:-** This claim represents the level of authentication assurance. It defines the method and context of authentication, which can be valuable for enforcing stronger security measures. |


### Keycloak specific JWT token claims

Keycloak also includes the following claims for session and access management:

| Claim name | Description |
|--------------------|----------------------------|
| `scope` | **Scope:-** This claim describes the permissions and access levels granted to the client application. This property defines the actions that the client is authorized to perform. |
| `realm_access` | **Realm access:-** This claim contains roles and permissions granted at the realm level. It specifies what the user can do globally within the realm. |
| `resource_access` | **Resource access:-** This claim contains roles and permissions granted to specific resources or applications. This property defines what actions the user can perform within particular client applications. |
| `session_state` | **Session state:-** This claim represents the state of the user's session. This property changes with each new session, allowing applications to track the user's active session and manage session-related actions. |


## Reference JWT tokens 

The following section includes reference JWT tokens for HCL's related products. Note that the JWT token is generated through the [HCL DS Keycloak reference implementation](../../../) and might look slightly different, depending on the IdP you use. Not all claims in the payload are used by HCL products but are part of the OIDC standard and the way Keycloak implements it. The important claims that are currently required for validation are highlighted.

To further understand token claims you can explore JWT tokens through the web app [JWT.io](https://jwt.io/), which allows you to decode, verify, and generate JWT tokens online.

### HCL Connections and Digital Experience (WebSphere OIDCRP)

HCL Connections (CNX) or HCL Digital Experience (DX), for example, can use the following JWT tokens. In general, the tokens are compatible with the [OIDC Relying Party Trust Association Interceptor](https://www.ibm.com/docs/en/was-nd/9.0.5?topic=users-configuring-openid-connect-relying-party) (OIDCRP TAI) for WebSphere. Note that CNX supports the WebSpere version up to 8.5.5, and DX supports the WebSphere versions up to 9.0.5. Based on the installed WebSphere version, some differences exist between the two products when it comes to the OIDCRP TAI also. This almost exclusively relates to additional configuration options but might also lead to a slightly different internal behavior or logging and troubleshooting options.

The following code is a snapshot of an access or bearer token generated by a Keycloak instance for CNX as the client or relying party and links to explore all tokens. 


#### Header (algorithm and token type)

```json
{
  "alg": "RS256",
  "typ": "JWT",
  "kid": "TbCK6sSW8z3tVkH93iXm97-SE4ImUujQEB4hA8VJ-1Q"
}
```

#### Payload (data)

```json
{
  "exp": 1687530857,
  "iat": 1687525459,
  "auth_time": 1687525457,
  "jti": "d85778fd-770a-41e8-9c0e-2ca01d3324ed",
  "iss": "https://keycloak.cnx.cwp.pnp-hcl.com/auth/realms/kcoidcpool",
  "aud": "account",
  "sub": "5ffb05fb-4a59-4c00-83b7-21bc2ea0b0f8",
  "typ": "Bearer",
  "azp": "lcautopool",
  "session_state": "077b95e7-a6de-455e-af6c-10e7c449fd71",
  "acr": "1",
  "realm_access": {
    "roles": [
      "offline_access",
      "uma_authorization"
    ]
  },
  "resource_access": {
    "account": {
      "roles": [
        "manage-account",
        "manage-account-links",
        "view-profile"
      ]
    }
  },
  "scope": "email openid profile",
  "email_verified": false,
  "realmName": "kcoidcpool",
  "name": "Adele Vance Vance",
  "preferred_username": "adelevance",
  "given_name": "Adele Vance",
  "family_name": "Vance",
  "email": "adelev@cygnus1.onmicrosoft.com"
}
```

Regarding the payload, pay attention to several properties when you configure or troubleshoot CNX or DX as a relying party against the IdP:

- The issuer (`iss`) is validated and must match the issuer configured on the WebSphere OIDC RP TAI config.
- The request must be validated in the timeframe between the issued-at (`iat`) and expiration time (`exp`) timestamps. The timestamps are based on system time and must be in synchronization between the IdP and client servers. Sometimes it is helpful or required to work with time discrepancies.
- The authorized party (`azp`) must match the client ID configured in the WebSphere OIDC RP TAI config.
- The `email` claim is the primary attribute for identifying a user on WebSphere. This identification status is in relation to the [user federation specifics](readme.md#user-federation) listed in the OIDC section. In general, a property must map to and contextualize the user with the CNX or DX application. The identifier can differ from the email attribute generally, but the email claim is used throughout this reference implementation.
- The `scope` must contain a scope that matches the one configured in the WebSphere OIDC RP TAI config.
- The `realmName` claim is a custom claim or hard-coded claim that matches the realm name of the OIDC provider and is validated by the WebSphere OIDC RP TAI against endpoints during the server-side OIDC exchange.

#### Signature

```json
{
  "e": "AQAB",
  "kty": "RSA",
  "n": "rCvz-IoBxoPprIsQ8KTqyk0j2jMy8MOvRSJGcgv8Q4HOLUGikOjq3APZSnwdyVHaPYyToWmVnN5n6PVPh2oCZQD7a9ckL_zqqYHGmUTyT7EpeZp5q9R4uy9p7aLF67uwgQNcZhSOpLZ5uV4SbStulqIE6DfDrrbpAnBTSBfrrWxv-tlUUaJCn9rAEK_3Y8SXd3GC4Ez9rV22WOqtfU5kHIO33twySNBFHkTLiz5JBXGC0ahPDVR0UBpf6egFFnkNAC1DqARSGnXtvGrSpDtB0X_vkQIvxpcEZ97LXMKLuSXxx0uWq8DnOpjUbbdL9ahTzQMfqlzVyezGjLUHFTcvbQ"
}
```

The signature is verified against the Base64 encoded header and payload. It can confirm they are valid (match) based on the RSASHA256 (RSA Signature with SHA-256) algorithm.

#### Full token overview and exploration

Refer to the following links to explore the preceding access token and the identity and refresh token:

- [Bearer Token by Keycloak for HCL Connections client | JTW.io](https://jwt.io/#debugger-io?token=eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJUYkNLNnNTVzh6M3RWa0g5M2lYbTk3LVNFNEltVXVqUUVCNGhBOFZKLTFRIn0.eyJleHAiOjE2ODc1MzA4NTcsImlhdCI6MTY4NzUyNTQ1OSwiYXV0aF90aW1lIjoxNjg3NTI1NDU3LCJqdGkiOiJkODU3NzhmZC03NzBhLTQxZTgtOWMwZS0yY2EwMWQzMzI0ZWQiLCJpc3MiOiJodHRwczovL2tleWNsb2FrLmNueC5jd3AucG5wLWhjbC5jb20vYXV0aC9yZWFsbXMva2NvaWRjcG9vbCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiI1ZmZiMDVmYi00YTU5LTRjMDAtODNiNy0yMWJjMmVhMGIwZjgiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJsY2F1dG9wb29sIiwic2Vzc2lvbl9zdGF0ZSI6IjA3N2I5NWU3LWE2ZGUtNDU1ZS1hZjZjLTEwZTdjNDQ5ZmQ3MSIsImFjciI6IjEiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgb3BlbmlkIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInJlYWxtTmFtZSI6Imtjb2lkY3Bvb2wiLCJuYW1lIjoiQWRlbGUgVmFuY2UgVmFuY2UiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhZGVsZXZhbmNlIiwiZ2l2ZW5fbmFtZSI6IkFkZWxlIFZhbmNlIiwiZmFtaWx5X25hbWUiOiJWYW5jZSIsImVtYWlsIjoiYWRlbGV2QGN5Z251czEub25taWNyb3NvZnQuY29tIn0.P9-UmQ-nc1QDTRFuaHg-DmhiS6jYOO96KQS72uzHyhH3H8olQ3RgXx6PqL-U1jBdMSr8QzkklFRa3qsn-_wWD4DL4PPiD71YM-piYUp_YMnmAWDTTlm0DgIKP6Hn3S-lpZz8IDrbnRQiKMSJq84Nib9CEuZPEYN5AsfVIjqpnTtUj-xwFQA5k5iiKVSbUyv_z1LlaW1dx2_aVjKpqovZ08aP1kmHkDRIyw0b-yiqpIibbaNsCJuDYp3oD_9RLAgEe8mHhVbiIin9fzMT6kuOFREyIDW-n1IQh4Qf9F9tsftjvP2RAIDI3PbB2Lpzhc6XCq9iXqN8P1fLTKQmbDhcwA&publicKey=%7B%0A%20%20%22e%22%3A%20%22AQAB%22%2C%0A%20%20%22kty%22%3A%20%22RSA%22%2C%0A%20%20%22n%22%3A%20%22rCvz-IoBxoPprIsQ8KTqyk0j2jMy8MOvRSJGcgv8Q4HOLUGikOjq3APZSnwdyVHaPYyToWmVnN5n6PVPh2oCZQD7a9ckL_zqqYHGmUTyT7EpeZp5q9R4uy9p7aLF67uwgQNcZhSOpLZ5uV4SbStulqIE6DfDrrbpAnBTSBfrrWxv-tlUUaJCn9rAEK_3Y8SXd3GC4Ez9rV22WOqtfU5kHIO33twySNBFHkTLiz5JBXGC0ahPDVR0UBpf6egFFnkNAC1DqARSGnXtvGrSpDtB0X_vkQIvxpcEZ97LXMKLuSXxx0uWq8DnOpjUbbdL9ahTzQMfqlzVyezGjLUHFTcvbQ%22%0A%7D)
- [Identity Token by Keycloak for HCL Connections client | JTW.io](https://jwt.io/#debugger-io?token=eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJUYkNLNnNTVzh6M3RWa0g5M2lYbTk3LVNFNEltVXVqUUVCNGhBOFZKLTFRIn0.eyJleHAiOjE2ODc1MzA4NTcsImlhdCI6MTY4NzUyNTQ1OSwiYXV0aF90aW1lIjoxNjg3NTI1NDU3LCJqdGkiOiI0ZDQzMDk2MS1iYWJlLTQ4MDQtOTIxOC00NDk0MDg1NWI0ZWIiLCJpc3MiOiJodHRwczovL2tleWNsb2FrLmNueC5jd3AucG5wLWhjbC5jb20vYXV0aC9yZWFsbXMva2NvaWRjcG9vbCIsImF1ZCI6ImxjYXV0b3Bvb2wiLCJzdWIiOiI1ZmZiMDVmYi00YTU5LTRjMDAtODNiNy0yMWJjMmVhMGIwZjgiLCJ0eXAiOiJJRCIsImF6cCI6ImxjYXV0b3Bvb2wiLCJzZXNzaW9uX3N0YXRlIjoiMDc3Yjk1ZTctYTZkZS00NTVlLWFmNmMtMTBlN2M0NDlmZDcxIiwiYXRfaGFzaCI6IjNhcVFxZVk5b2t4VXBoSXpUNUJOTnciLCJhY3IiOiIxIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJyZWFsbU5hbWUiOiJrY29pZGNwb29sIiwibmFtZSI6IkFkZWxlIFZhbmNlIFZhbmNlIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiYWRlbGV2YW5jZSIsImdpdmVuX25hbWUiOiJBZGVsZSBWYW5jZSIsImZhbWlseV9uYW1lIjoiVmFuY2UiLCJlbWFpbCI6ImFkZWxldkBjeWdudXMxLm9ubWljcm9zb2Z0LmNvbSJ9.OB3pZNoTD6I4gboLaFk8Y_Zv_dqx76MYwWqHpyaZ8wtkGw83KSu2TstVsUV6ZDWDiH04C9_9cGkhUn-_BbYbGHC7BUN5FQUCavrLzXHPSmBl9gzvpEZlA3tuuVK5iZ_pzHcxyHRA064v1mAQwUpuPTlyCzqfcBq3BoeRXMDHBy-zUW1HWa9ojrvO7R2-81Iw5JMXkDQG2rjIWeIu6tGQ0dr1bb1vWg10U5bO5vvlb3hlX_6Yp1YdTkjBh5i18ill_POdsfaxtpvfxHZoBxBqLHSWQEQ_WRmBiVSK0onmMep-2Kbm1O3BlwNK3cJ8oLeO6Yuz5my5gh-UtpZbeZq9nA&publicKey=%7B%0A%20%20%22e%22%3A%20%22AQAB%22%2C%0A%20%20%22kty%22%3A%20%22RSA%22%2C%0A%20%20%22n%22%3A%20%22rCvz-IoBxoPprIsQ8KTqyk0j2jMy8MOvRSJGcgv8Q4HOLUGikOjq3APZSnwdyVHaPYyToWmVnN5n6PVPh2oCZQD7a9ckL_zqqYHGmUTyT7EpeZp5q9R4uy9p7aLF67uwgQNcZhSOpLZ5uV4SbStulqIE6DfDrrbpAnBTSBfrrWxv-tlUUaJCn9rAEK_3Y8SXd3GC4Ez9rV22WOqtfU5kHIO33twySNBFHkTLiz5JBXGC0ahPDVR0UBpf6egFFnkNAC1DqARSGnXtvGrSpDtB0X_vkQIvxpcEZ97LXMKLuSXxx0uWq8DnOpjUbbdL9ahTzQMfqlzVyezGjLUHFTcvbQ%22%0A%7D)
- [Refresh Token by Keycloak for HCL Connections client | JTW.io](https://jwt.io/#debugger-io?token=eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0NjM2NGMxZS1iZjk4LTQwNDQtODc0MS1iYzdlYWQ0OTRiNjIifQ.eyJleHAiOjE2ODc1MjYxNzksImlhdCI6MTY4NzUyNTQ1OSwianRpIjoiZDE5YTI4YmMtNWZlNC00ZGZiLTljZTctMzVmZjkyYzJhMDdkIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay5jbnguY3dwLnBucC1oY2wuY29tL2F1dGgvcmVhbG1zL2tjb2lkY3Bvb2wiLCJhdWQiOiJodHRwczovL2tleWNsb2FrLmNueC5jd3AucG5wLWhjbC5jb20vYXV0aC9yZWFsbXMva2NvaWRjcG9vbCIsInN1YiI6IjVmZmIwNWZiLTRhNTktNGMwMC04M2I3LTIxYmMyZWEwYjBmOCIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJsY2F1dG9wb29sIiwic2Vzc2lvbl9zdGF0ZSI6IjA3N2I5NWU3LWE2ZGUtNDU1ZS1hZjZjLTEwZTdjNDQ5ZmQ3MSIsInNjb3BlIjoiZW1haWwgb3BlbmlkIHByb2ZpbGUifQ.Iy405IAmtHDVKijkaXl0g9wh3Jqy16FIRvU-7061do4)
