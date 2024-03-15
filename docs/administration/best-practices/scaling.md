
# Scaling Keycloak

## Manual Scaling

Kubernetes allows us to scale both Deployments and Statefulsets but they differ on how it can be scaled.

### Scaling a Deployment

For scaling a Deployment Kubernetes provides commands on how this can be achieved. Please refer to
[Scaling a Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment) for further guiadance.

### Scaling a Statefulset

Scaling a StatefulSet refers to increasing or decreasing the number of replicas. Please refer to [Scale a StatefulSet](https://kubernetes.io/docs/tasks/run-application/scale-stateful-set/) topic for further guiadance.

## ReplicaSet (RS)

A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods.

Please refer to [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) for further guiadance.

## HorizontalPodAutoscaling (HPA)

In Kubernetes, a HorizontalPodAutoscaler automatically updates a workload resource (such as a Deployment or StatefulSet), with the aim of automatically scaling the workload to match demand.

Horizontal scaling means that the response to increased load is to deploy more Pods. This is different from vertical scaling, which for Kubernetes would mean assigning more resources (for example: memory or CPU) to the Pods that are already running for the workload.

If the load decreases, and the number of Pods is above the configured minimum, the HorizontalPodAutoscaler instructs the workload resource (the Deployment, StatefulSet, or other similar resource) to scale back down.

For more information refer to [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)

## Summary

A ReplicaSet ensures that a specified number of pod replicas are running at any given time. However, a Deployment is a higher-level concept that manages ReplicaSets and provides declarative updates to Pods. Therefore it is recommended using Deployments instead of using ReplicaSet directly.

StatefulSet differs how they can be scaled up and down in comparison to Deployments as stateful applications need one or more of the following:

- Stable, unique network identifiers.
- Stable, persistent storage.
- Ordered, graceful deployment and scaling.
- Ordered, automated rolling updates.

ReplicaSet are a good starting point if the requirement is that we need n pods available to distribute the load. But if we need a dynamic scaling then it is best we use [Horizontal Pod Autoscaling (HPA)](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
