# Uninstall 

To remove your Keycloak deployment from your Cluster deployed using Helm, it is recommended that you use Helm uninstall.

## Uninstalling Keycloak

To uninstall/delete the `hclds-keycloak` deployment, run the following command:

```sh
helm uninstall hclds-keycloak
```

After a successfully removing the application, Helm responds with the following message:

```sh
release hclds-keycloak uninstalled
```

## Delete the PersistentVolumeClaim (PVC) for PostgreSQL
If you also want to delete the PostgreSQL data along with the Keycloak uninstallation, you need to delete the associated PersistentVolumeClaim (PVC) for PostgreSQL via `kubectl`.
First, identify the pvc in question:

```sh
kubectl get pvc
NAME                         STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data-keycloak-postgresql-0   Bound    pvc-13869fd0-92aa-488c-89c8-7be6fd9512fd   8Gi        RWO            hostpath       63d
```

Afterwards, delete it:
```sh
kubectl delete pvc data-keycloak-postgresql-0
```

To check the PVCs in your Kubernetes cluster, you can use the kubectl command-line tool. Here's how you can check PVCs:
```sh
kubectl get pvc
```

## Verify Uninstallation
After running the uninstall command for both Keycloak and PostgreSQL, Helm will remove the installations from your cluster. Additionally, if you deleted the PostgreSQL PVC, the associated data will also be removed.

After uninstalling Keycloak using Helm, you can check the Helm releases to ensure that the release has been successfully deleted. Run the following command:
```sh
helm list
```
Run the following command to verify that the Kubernetes resources (pods, services, deployments, etc.) associated with Keycloak and PostgreSQL have been removed:
```sh
kubectl get all | grep keycloak
```
Verify that there are no lingering PersistentVolumeClaims:
```sh
kubectl get pvc
```