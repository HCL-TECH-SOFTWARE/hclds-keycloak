# Configuration and Options

The Keycloak image supports a variety of configuration options to cater the service to your needs and set up. There are two ways to incorporating configuration. 

## Helm chart custom values

The first option are overwrites to the `values.yaml` configuration provided via our Helm charts. These are heavily inheriting from Bitnami, so most of the  Bitnami based configuration options can be carried forward without change.

You can learn more about the Helm chart configuration options [here](../../deployment/helm/hclds-keycloak/#parameters).


## Docker environment variables

The second option is to provide environment variables directly into the docker container. Many of the Helm chart based values are also doing just that internally. Most configuration properties can be found when looking through the official [Keycloak server guides](https://www.keycloak.org/guides#server).

One important note here is that there might be a difference in naming between the Bitnami image we are using and the [original Keycloak image hosted on Quay.io](https://quay.io/repository/keycloak/keycloak). The list below provides an overview of most available properties and how names may have to be adjusted. In most cases the difference is that Bitnami prefaces a property with `KEYCLOAK_`, whereas in the original image it is prefaced with `KC_`. 

For finding more details about any particular property or when using the resources in the Keycloak server guides, please be aware of this difference as properties you find there might require a respective change in naming to be properly understood by the image we use.

### Using docker variables

To use these variables in your **Docker** container, simply add them via the `-e` or `--env` flag during your `docker run` command, e.g.

```sh
docker run -e KEYCLOAK_ADMIN='hcladmin' -e KEYCLOAK_ADMIN_PASSWORD='hcladmin' hclds-keycloak
```

In **Docker Compose**, you can also add them directly to your `docker-compose.yaml` like in [this one](../../deployment/docker-compose/docker-compose.yaml).

When using **Helm charts** to deploy on Kubernetes, these properties can also be provided directly by using the `extraEnvVars` property inside the `values.yaml` file like in the below sample. Note that most properties are exposed through the values configuration directly instead of the extraEnvVars property.

```yaml
extraEnvVars:
    KEYCLOAK_ADMIN: "hcladmin"
    KEYCLOAK_ADMIN_PASSWORD: "hcladmin"
```


### Overview of variables

| Name (for Bitnami image)    | Name (for Quay.io image)     | Description           | Default value                  |
| ----------------------------| ---------------------------- | --------------------- | ------------------------------ |
| `KEYCLOAK_ADMIN`    | `KEYCLOAK_ADMIN`    | Keycloak administrator username        | `"admin"`           |
| `KEYCLOAK_ADMIN_PASSWORD` |  `KEYCLOAK_ADMIN_PASSWORD` | Keycloak administrator password | `"admin"`                |
| `KEYCLOAK_DEFAULT_THEME`     | `KEYCLOAK_DEFAULT_THEME` | Custom created default theme for keycloak    | `hcl`  |
| `KEYCLOAK_EXTRA_ARGS`    | `KEYCLOAK_EXTRA_ARGS`    | Extra args to import realm during start up                    | `--import-realm`  |
| `KEYCLOAK_IMPORT` | `KEYCLOAK_IMPORT` | Set realm import strategy to ignore if realm exists | `ignore`  |
| `KEYCLOAK_IMPORT_REALM_NAME`     | `KEYCLOAK_IMPORT_REALM_NAME`     | Name of the realm that you want to import during startup     | `hcl`  |
| `KEYCLOAK_IMPORT_CLIENT_ID`     | `KEYCLOAK_IMPORT_CLIENT_ID`     | Client ID of the realm that you want to import during startup    | `common-services-oidc-client`  |
| `KEYCLOAK_HOSTNAME`     | `KC_HOSTNAME`     | Hostname for the Keycloak server   |   |
| `KEYCLOAK_HTTP_RELATIVE_PATH`     | `KC_HTTP_RELATIVE_PATH`     | Set the path relative to / for serving resources.    | `/`  |
| `KEYCLOAK_HTTP_PORT`     | `KC_HTTP_PORT`     | Keycloak HTTP container port    | `8080`  |
| `KEYCLOAK_HTTPS_PORT`     | `KC_HTTPS_PORT`     | Keycloak HTTPS container port    | `8443`  |
| `KEYCLOAK_PROXY`     | `KC_PROXY`     | The proxy address forwarding mode if the server is behind a reverse proxy.    | `passthrough`  |
| `KEYCLOAK_HTTPS_TRUST_STORE_FILE`     | `KC_HTTPS_TRUST_STORE_FILE`     | The trust store which holds the certificate information of the certificates to trust.    |   |
| `KEYCLOAK_HTTPS_TRUST_STORE_PASSWORD`     | `KC_HTTPS_TRUST_STORE_PASSWORD`     | The password of the trust store file.    |   |
| `KEYCLOAK_HTTPS_KEY_STORE_FILE`     | `KC_HTTPS_KEY_STORE_FILE`     | The key store which holds the certificate information instead of specifying separate files.    |   |
| `KEYCLOAK_HTTPS_KEY_STORE_PASSWORD`     | `KC_HTTPS_KEY_STORE_PASSWORD`     | The password of the key store file    | `password` |
| `KEYCLOAK_HTTPS_CERTIFICATE_FILE`     | `KC_HTTPS_CERTIFICATE_FILE`     | The file path to a server certificate or certificate chain in PEM format.    |  |
| `KEYCLOAK_HTTPS_CERTIFICATE_KEY_FILE`     | `KC_HTTPS_CERTIFICATE_KEY_FILE`     | The file path to a private key in PEM format.    |  |
| `KEYCLOAK_SPI_TRUSTSTORE_FILE`     | `KC_SPI_TRUSTSTORE_FILE_FILE`     | The file path of the SPI trust store from where the certificates are going to be read from to validate TLS connections.    |  |
| `KEYCLOAK_SPI_TRUSTSTORE_PASSWORD`     | `KC_SPI_TRUSTSTORE_FILE_PASSWORD`     | The SPI trust store password.    |  |
| `KEYCLOAK_SPI_TRUSTSTORE_FILE_HOSTNAME_VERIFICATION_POLICY`     | `KC_SPI_TRUSTSTORE_FILE_HOSTNAME_VERIFICATION_POLICY`     | The SPI hostname verification policy.    | `any, wildcard (default), strict` |
| `KEYCLOAK_DATABASE_VENDOR`     | `KC_DB`     | The database vendor    | `dev-file (default), dev-mem, mariadb, mssql, mysql, oracle, postgres` |
| `KEYCLOAK_DATABASE_HOST`     | `KC_DB_URL_HOST`     | Sets the hostname of the default JDBC URL of the chosen vendor.    |  |
| `KEYCLOAK_DATABASE_PORT`     | `KC_DB_URL_PORT`     | Sets the port of the default JDBC URL of the chosen vendor.    |  |
| `KEYCLOAK_DATABASE_USER`     | `KC_DB_USERNAME`     | The username of the database user.    |  |
| `KEYCLOAK_DATABASE_PASSWORD`     | `KC_DB_PASSWORD`     | The password of the database user.   |  |
| `KEYCLOAK_DATABASE_NAME`     | `KC_DB_URL_DATABASE`     | Sets the database name of the default JDBC URL of the chosen vendor.    |  |
| `KEYCLOAK_DATABASE_SCHEMA`     | `KC_DB_SCHEMA`     | The database schema to be used.    |  |
| `KEYCLOAK_JDBC_PARAMS`     | `KC_DB_URL_PROPERTIES`     | The database JDBC parameters.    |  |
| `KEYCLOAK_LOG_OUTPUT`     | `KC_LOG`     | Enable one or more log handlers in a comma-separated list.    | `console (default), file, gelf`  |
| `KEYCLOAK_LOG_LEVEL`     | `KC_LOG_LEVEL`     | The log level of the root category or a comma-separated list of individual categories and their levels.    | `info`  |
| `KEYCLOAK_CACHE_TYPE`     | `KC_CACHE`     | Defines the cache mechanism for high-availability.    | `ispn (default), local`  |
| `KEYCLOAK_CACHE_STACK`     | `KC_CACHE_STACK`     | Define the default stack to use for cluster communication and node discovery.This option only takes effect if cache is set to ispn.    | `udp (default), tcp, kubernetes, ec2, azure, google`  |
| `KEYCLOAK_CACHE_CONFIG_FILE`     | `KC_CACHE_CONFIG_FILE`     | Defines the file from which cache configuration should be loaded from    |   |
| `KEYCLOAK_ENABLE_HEALTH_ENDPOINTS`     | `KC_HEALTH_ENABLED`     | If the server should expose health check endpoints.If enabled, health checks are available at the /health, /health/ready and /health/live endpoints.    | `false`  |
| `KEYCLOAK_BIND_ADDRESS`     |      | Keycloak bind address.    | `0.0.0.0.`  |
| `KEYCLOAK_INIT_MAX_RETRIES`     |      | It defines the maximum number of retries that the Keycloak initialization process will attempt before giving up.    | `10`  |
| `KEYCLOAK_ENABLE_STATISTICS`     |      | The Bitnami Keycloak container can activate different set of statistics (database,jgroups and http) by setting the environment variable KEYCLOAK_ENABLE_STATISTICS=true.    | `false`  |
| `KEYCLOAK_ENABLE_HTTPS`     |      | Enable TLS encryption using the keystore.    | `false`  |
| `KEYCLOAK_HTTPS_USE_PEM`     |      | Set to true to configure HTTPS using PEM certificates.    | `false`  |
| `KEYCLOAK_PRODUCTION`     |      | Set it to TRUE to run Keycloak in production mode.    |   |
| `KEYCLOAK_EXTRA_ARGS_PREPENDED`     |      | If you need flags which are applied directly to keycloak executable, you can use KEYCLOAK_EXTRA_ARGS_PREPENDED variable.    |   |
