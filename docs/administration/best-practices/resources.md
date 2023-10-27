# Resource Management for Pods and Containers

When you specify a Pod, you can optionally specify how much of each resource a container needs. The most common resources to specify are CPU and memory (RAM); there are [others](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-types).

When you specify the resource request for containers in a Pod, the kube-scheduler uses this information to decide which node to place the Pod on. When you specify a resource limit for a container, the kubelet enforces those limits so that the running container is not allowed to use more of that resource than the limit you set. The kubelet also reserves at least the request amount of that system resource specifically for that container to use.

For more information please refer to [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

## Requests and limits

If the node where a Pod is running has enough of a resource available, it's possible (and allowed) for a container to use more resource than its `request` for that resource specifies. However, a container is not allowed to use more than its resource `limit`.

For example, if you set a `memory` request of 256 MiB for a container, and that container is in a Pod scheduled to a Node with 8GiB of memory and no other Pods, then the container can try to use more RAM.

## Resource requests and limits of Pod and container

For each container, you can specify resource limits and requests including:

- `spec.containers[].resources.limits.cpu`
- `spec.containers[].resources.limits.memory`
- `spec.containers[].resources.limits.hugepages-<size>`
- `spec.containers[].resources.requests.cpu`
- `spec.containers[].resources.requests.memory`
- `spec.containers[].resources.requests.hugepages-<size>`

Although you can only specify requests and limits for individual containers, it is also useful to think about the overall resource requests and limits for a Pod. For a particular resource, a Pod resource request/limit is the sum of the resource requests/limits of that type for each container in the Pod.

## Resource units in Kubernetes

### CPU resource units

Limits and requests for CPU resources are measured in cpu units. In Kubernetes, 1 CPU unit is equivalent to **1 physical CPU core**, or **1 virtual core**, depending on whether the node is a physical host or a virtual machine running inside a physical machine.

### Memory resource units

Limits and requests for `memory` are measured in bytes. You can express memory as a plain integer or as a fixed-point number using one of these quantity suffixes: E, P, T, G, M, k. You can also use the power-of-two equivalents: Ei, Pi, Ti, Gi, Mi, Ki. For example, the following represent roughly the same value:

```
128974848, 129e6, 129M,  128974848000m, 123Mi
```

## Summary

It is always a good practice to provide least required resource requirements for your containers. To identify minimum requirements refer to the installation guide for the product being deployed.

Currently in our helm chart we do not define any resource requests or limits. Also the helm chart we use that does not provide any default values for our authentication service.

```yaml
## Keycloak resource requests and limits
## ref: https://kubernetes.io/docs/user-guide/compute-resources/
## @param resources.limits The resources limits for the Keycloak containers
## @param resources.requests The requested resources for the Keycloak containers
##
resources:
  limits: {}
  requests: {}
```

If we refer to [DX Helm Chart](https://git.cwp.pnp-hcl.com/websphere-portal-incubator/dx-helm-charts) we can see how requests and limits can be specified.

```yaml
# Resource allocation settings, definition per pod
# Use number + unit, e.g. 1500m for CPU or 1500M for Memory
resources:
  # Content composer resource allocation
  contentComposer:
    requests:
      cpu: "100m"
      memory: "192Mi"
    limits:
      cpu: "100m"
      memory: "192Mi"
  # Core resource allocation
  core:
    requests:
      cpu: "2000m"
      memory: "4096Mi"
    limits:
      cpu: "4000m"
      memory: "6144Mi"
```
