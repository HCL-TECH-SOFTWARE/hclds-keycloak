# Installation and Deployment

The installation and deployment of the Keycloak service leverages Helm charts to define the layout of the deployment in a Kubernetes environment. The following sections provide details on common installation steps, optional and environment specific considerations and available configuration options to adjust the installation to your needs.

## Building the image

The Helm chart expects the image `hclds-keycloak:latest` to be available on the system in order to properly start the service. Ensure this image is available on your system before running the following installation steps.

```sh
docker image ls | grep hclds-keycloak
hclds-keycloak                                                                  latest                  d2a806a74638   2 minutes ago   642MB
```

If the image is not available yet, please refer to the section around [building the image for the service](../docker.md#build-the-container-for-the-service).

## Installing the Chart

To install the chart on local with the release name `hclds-keycloak`, go to [deployment/helm/hclds-keycloak](../../../deployment/helm/hclds-keycloak/) and run:

```console
helm install hclds-keycloak .
```

This command deploys a Keycloak application on the Kubernetes cluster in the default configuration.

After execution, make sure the `hclds-keycloak` statefulset including its service and pods all have been created and are up and running via the following command:

```sh
kubectl get all
```

```sh
NAME                                          READY   STATUS              RESTARTS   AGE
pod/hclds-keycloak-0              1/1     Running             0          56s
pod/hclds-keycloak-postgresql-0   1/1     Running             0          56s

NAME                                               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/hclds-keycloak                 ClusterIP   10.108.126.123   <none>        80/TCP,443/TCP   56s
service/hclds-keycloak-headless        ClusterIP   None             <none>        80/TCP,443/TCP   56s
service/hclds-keycloak-postgresql      ClusterIP   10.102.67.137    <none>        5432/TCP         56s
service/hclds-keycloak-postgresql-hl   ClusterIP   None             <none>        5432/TCP         56s

NAME                                                     READY   AGE
statefulset.apps/hclds-keycloak              1/1     56s
statefulset.apps/hclds-keycloak-postgresql   1/1     56s
```

**Note**: The statefulset and pods might take a couple of seconds to show as fully ready. If this takes longer than 2 or 3 minutes, consider checking the logs to assert if the service is still processing/starting or whether it might have run into some issue. The most likely reason for issues should be a malformed yaml file or incorrect values like hostname and ports within it. The logs can be viewed via the command:

```sh
kubectl logs pod/hclds-keycloak-0
```

## Keycloak can be accessed through the following DNS name from within your cluster:

```console
    hclds-keycloak.default.svc.cluster.local (port 80)
```

## Access via port-forwarding

The most straight forward way of accessing Keycloak is by exposing the service through port-forwarding:

```console
kubectl port-forward svc/hclds-keycloak 8080:80
```

output:

```console
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
```

In case HTTPS was enabled, you can also expose the SSL port:

```console
kubectl port-forward svc/hclds-keycloak 8443:443
```

output:

```console
Forwarding from 127.0.0.1:8443 -> 8443
Forwarding from [::1]:8443 -> 8443
Handling connection for 8443
Handling connection for 8443
```

You can certainly adjust ports as needed.

From here, open [https://localhost:8443](https://localhost:8443) or [http://localhost:8080](http://localhost:8080) on your browser to check it.

Try logging in to the Administrative Console with user `admin:admin` and start using the Keycloak service.

## Access via ingress

The helm charts allow you to automatically expose the service through an existing ingress service. To do so, you can add, for example, the following section to your `custom-values.yaml` file:

```yaml
# leverage DX ingress and wire it up
ingress:
  enabled: true
  ingressClassName: "nginx"
  hostname: <HOSTNAME>
  tls: true
  selfSigned: true
```

Please find more information on custom values and configuration in the section around [configuration parameters](./configuration-properties.md).

## Configure and customize your deployment

From here on start configuring the Keycloak service instance. Create or import realms and clients, add user federation providers and more! Also, try to hook DX into the mix by configuring it for OIDC.

From a developers perspective, feel free to play around with properties, e.g. try HA with replicaSets or add new init containers.
