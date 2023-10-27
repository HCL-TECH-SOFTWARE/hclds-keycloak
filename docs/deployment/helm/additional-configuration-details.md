# Additional configuration and installation details

There are more configuration tasks, options and details that are relevant for specific aspects of deploying the Keycloak service. Not all of them may be relevant for your particular use case.


## [Rolling vs Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

## Use an external database

Sometimes, you may want to have Keycloak connect to an external PostgreSQL database rather than a database within your cluster - for example, when using a managed database service, or when running a single database server for all your applications. To do this, set the `postgresql.enabled` parameter to `false` and specify the credentials for the external database using the `externalDatabase.*` parameters.

Refer to the [chart documentation on using an external database](https://docs.bitnami.com/kubernetes/apps/keycloak/configuration/use-external-database) for more details and an example.

> NOTE: Only PostgreSQL database server is supported as external database

It is not supported but possible to run Keycloak with an external MSSQL database with the following settings:

```yaml
externalDatabase:
  host: "mssql.example.com"
  port: 1433
  user: keycloak
  database: keycloak
  existingSecret: passwords
extraEnvVars:
  - name: KC_DB # override values from the conf file
    value: 'mssql'
  - name: KC_DB_URL
    value: 'jdbc:sqlserver://mssql.example.com:1433;databaseName=keycloak;'
```

### Setting up an HA PostgreSQL instance

A common requirement for more production grade setup is high availability. The default PostgreSQL instance deployed through helm chart only runs in a single replication or can be set up to run in a setup with additonal read-only nodes. An HA-enabled setup builds on the above steps around using an external database. You can find more details and instructions around this in the section on [using a highly available PostgreSQL database](./using-postgres-ha.md).


## Add extra environment variables

In case you want to add extra environment variables (useful for advanced operations like custom init scripts), you can use the `extraEnvVars` property.

```yaml
extraEnvVars:
  - name: KEYCLOAK_LOG_LEVEL
    value: DEBUG
```

Alternatively, you can use a ConfigMap or a Secret with the environment variables. To do so, use the `extraEnvVarsCM` or the `extraEnvVarsSecret` values.

## Use Sidecars and Init Containers

If additional containers are needed in the same pod (such as additional metrics or logging exporters), they can be defined using the `sidecars` config parameter. Similarly, extra init containers can be added using the `initContainers` parameter.

Refer to the chart documentation for more information on, and examples of, configuring and using [sidecars and init containers](https://docs.bitnami.com/kubernetes/apps/keycloak/configuration/configure-sidecar-init-containers/).

## Initialize a fresh instance

The [Bitnami Keycloak](https://github.com/bitnami/containers/tree/main/bitnami/keycloak) base image allows you to use your custom scripts to initialize a fresh instance. In order to execute the scripts, you can specify custom scripts using the `initdbScripts` parameter as dict.

In addition to this option, you can also set an external ConfigMap with all the initialization scripts. This is done by setting the `initdbScriptsConfigMap` parameter. Note that this will override the previous option.

The allowed extensions is `.sh`.

## Deploy extra resources

There are cases where you may want to deploy extra objects, such a ConfigMap containing your app's configuration or some extra deployment with a micro service used by your app. For covering this case, the chart allows adding the full specification of other objects using the `extraDeploy` parameter.

## Set Pod affinity

This chart allows you to set your custom affinity using the `affinity` parameter. Find more information about Pod's affinity in the [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, you can use of the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [bitnami/common](https://github.com/bitnami/charts/tree/main/bitnami/common#affinities) chart. To do so, set the `podAffinityPreset`, `podAntiAffinityPreset`, or `nodeAffinityPreset` parameters.

## Configure Ingress

This chart provides support for Ingress resources. If you have an ingress controller installed on your cluster, such as [nginx-ingress-controller](https://github.com/bitnami/charts/tree/main/bitnami/nginx-ingress-controller) or [contour](https://github.com/bitnami/charts/tree/main/bitnami/contour) you can utilize the ingress controller to serve your application.

To enable Ingress integration, set `ingress.enabled` to `true`. The `ingress.hostname` property can be used to set the host name. The `ingress.tls` parameter can be used to add the TLS configuration for this host. It is also possible to have more than one host, with a separate TLS configuration for each host. [Learn more about configuring and using Ingress](https://docs.bitnami.com/kubernetes/apps/keycloak/configuration/configure-ingress/).

## Configure TLS Secrets for use with Ingress

The chart also facilitates the creation of TLS secrets for use with the Ingress controller, with different options for certificate management. [Learn more about TLS secrets](https://docs.bitnami.com/kubernetes/apps/keycloak/administration/enable-tls-ingress/).

## Use with ingress offloading SSL

If your ingress controller has the SSL Termination, you should set `proxy` to `edge`.

## Manage secrets and passwords

This chart provides several ways to manage passwords:

- Values passed to the chart
- An existing secret with all the passwords (via the `existingSecret` parameter)
- Multiple existing secrets with all the passwords (via the `existingSecretPerPassword` parameter)

Refer to the [chart documentation on managing passwords](https://docs.bitnami.com/kubernetes/apps/keycloak/configuration/manage-passwords/) for examples of each method.