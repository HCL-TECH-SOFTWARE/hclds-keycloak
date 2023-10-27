# Using PostgreSQL high availability database

## Overview

By default, the HCL Digital Solutions Keycloak services uses a PostgreSQL instance that can be deployed in both `standalone (default)` and `replication` architecture. When using the `replication` architecture, PostgreSQL can be deployed in a cluster using master-slave topology. The master (or primary) node has writing permissions while replication is on the secondary nodes which have read-only permissions. Although if a primary node goes down our service would not be operational until it is up and running again, as it orchestrates communication.

To overcome this we can use PostgreSQL HA as it provides a solution for managing replication and failover on PostgreSQL clusters. The PostgreSQL HA Helm chart deploys a cluster with three nodes by default, one for pgpool, one master and one slave for PostgreSQL. The pgpool is responsible for handling connections to the nodes and acts as a loadbalancer for the database by re-directing the queries to the appropriate nodes. In addition, PostgreSQL deploys a `repmgr` module that ensures high availability. If the master is down, one of the slave nodes will be promoted to become the new master instead.

## Deploying PostgreSQL HA

Bitnami provides a helm chart for deploying postgresql-ha on Kubernetes. You can find more information on the chart [here](https://github.com/bitnami/charts/blob/main/bitnami/postgresql-ha/README.md).

### Adding helm repository

Before we install a helm chart we need to ensure that we have a helm repository added. To add the repository run following command.

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Once the repository is added you will see output as below:

```sh
"bitnami" has been added to your repositories
```

If we want to verify if the repository was added to helm we can do so by running following command

```sh
helm repo ls 
```

This command will output list of all repositories available in helm as below:

```sh
NAME                	URL                                                                  
bitnami             	https://charts.bitnami.com/bitnami 
```

### Updating helm repository

To ensure that we are using latest helm charts we need to update our repositories by running following command.

```sh
helm repo update
```

Once helm updates the repositories it would output as below:

```sh
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
```

### Searching for a required helm chart

There are more than one chart that Bitnami provides for PostgreSQL so we can search the repo by running following commands:

```sh
helm search repo postgres
```

Once the command runs it shows available charts matching the search criteria as below:

```sh
NAME                 	CHART VERSION	APP VERSION	DESCRIPTION                                       
bitnami/postgresql   	12.6.5       	15.3.0     	PostgreSQL (Postgres) is an open source object-...
bitnami/postgresql-ha	11.7.7       	15.3.0     	This PostgreSQL cluster solution includes the P...
```

If you want to use a specific version of the helm chart you can run following commands:

```sh
helm search repo bitnami/postgresql-ha --versions
```

It would list available versions as below:

```sh
NAME                 	CHART VERSION	APP VERSION	DESCRIPTION                                       
bitnami/postgresql-ha	11.7.9       	15.3.0     	This PostgreSQL cluster solution includes the P...
bitnami/postgresql-ha	11.7.8       	15.3.0     	This PostgreSQL cluster solution includes the P...
bitnami/postgresql-ha	11.7.7       	15.3.0     	This PostgreSQL cluster solution includes the P...
...
```

### Create a namespace for Postgres HA

This is an optional step, if we want to install the PostgreSQL HA helm chart in a namespace other than `default`, we can create a namespace by running following command. Here we will be creating a separate namespace for our PostgreSQL HA deployment.

```sh
kubectl create ns ha-db
```

Once the namespace is created we will see following output:

```sh
namespace/ha-db created
```

### Overriding values in the helm chart

We need to override certain values before we install the helm chart provided. This can be done by creating a `custom-values.yaml` file that can have values we want to override.

For creating the custom values file we run following command:

```sh
vi custom-values.yaml
```

Once the editor opens paste below contents in the `custom-values.yaml` file and save it.

```yaml
postgresql:
  ## PostgreSQL configuration parameters
  ## @param postgresql.username PostgreSQL username
  ## @param postgresql.password PostgreSQL password
  ## @param postgresql.database PostgreSQL database
  ##
  username: dbuser
  password: password
  database: keycloak_db

  ## @param postgresql.postgresPassword PostgreSQL password for the `postgres` user when `username` is not `postgres`
  ## ref: https://github.com/bitnami/containers/tree/main/bitnami/postgresql#creating-a-database-user-on-first-run (see note!)
  ##
  postgresPassword: password

  ## Repmgr configuration parameters
  ## @param postgresql.repmgrUsername PostgreSQL Repmgr username
  ## @param postgresql.repmgrPassword PostgreSQL Repmgr password
  ## @param postgresql.repmgrDatabase PostgreSQL Repmgr database
  repmgrUsername: dbrepmgr
  repmgrPassword: password
  repmgrDatabase: repmgr
```

### Running helm install

Before we install the chart let us look at different parameters that we need to build the command. Here is how the install command looks like with placeholders.

```sh
helm install <RELEASE_NAME> <HELM_CHART_REPO>/<HELM_CHART_NAME> --values <CUSTOM_VALUES_FILE_NAME> -n <NAMESPACE>
```

- The &lt;RELEASE_NAME&gt; is the Helm release name and prefixes all resources created in that installation. We can provide any name for the release, for now we will use `persistence`.

- The &lt;NAMESPACE&gt is the namespace where deployment is installed to. Here we will use `ha-db`.

- The &lt;CUSTOM_VALUES_FILE_NAME&gt; you have created in the current directory, which contains all deployment configuration. Here we have created `custom-values.yaml`.

- The &lt;HELM_CHART_REPO&gt; and &lt;HELM_CHART_NAME&gt; is helm chart repo and name. In our case it would be `bitnami/postgresql-ha`

Once we replace the placeholders with our values, here is how the install command now looks like:

```sh
helm install persistence bitnami/postgresql-ha --values custom-values.yaml -n ha-db
```

Once the installation begins we see following installation status as below:

```sh
NAME: persistence
LAST DEPLOYED: Thu Jul 13 17:09:16 2023
NAMESPACE: ha-db
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql-ha
CHART VERSION: 11.7.7
APP VERSION: 15.3.0
** Please be patient while the chart is being deployed **
PostgreSQL can be accessed through Pgpool via port 5432 on the following DNS name from within your cluster:

    persistence-postgresql-ha-pgpool.ha-db.svc.cluster.local

Pgpool acts as a load balancer for PostgreSQL and forward read/write connections to the primary node while read-only connections are forwarded to standby nodes.

To get the password for "dbuser" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace ha-db persistence-postgresql-ha-postgresql -o jsonpath="{.data.password}" | base64 -d)

To get the password for "dbrepmgr" run:

    export REPMGR_PASSWORD=$(kubectl get secret --namespace ha-db persistence-postgresql-ha-postgresql -o jsonpath="{.data.repmgr-password}" | base64 -d)

To connect to your database run the following command:

    kubectl run persistence-postgresql-ha-client --rm --tty -i --restart='Never' --namespace ha-db --image docker.io/bitnami/postgresql-repmgr:15.3.0-debian-11-r16 --env="PGPASSWORD=$POSTGRES_PASSWORD"  \
        --command -- psql -h persistence-postgresql-ha-pgpool -p 5432 -U dbuser -d keycloak_db

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace ha-db svc/persistence-postgresql-ha-pgpool 5432:5432 &
    psql -h 127.0.0.1 -p 5432 -U dbuser -d keycloak_db
```

### Verify if deployment was successful

Once the installation has started we can then verify if all nodes are up and by running following command:

```sh
kubectl get all -o wide -n ha-db
```

Once the above command runs we will see following output:

```sh
NAME                                                    READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
pod/persistence-postgresql-ha-pgpool-74b8644669-494xk   1/1     Running   0          7s    10.244.0.225   minikube   <none>           <none>
pod/persistence-postgresql-ha-postgresql-0              1/1     Running   0          7s    10.244.0.226   minikube   <none>           <none>
pod/persistence-postgresql-ha-postgresql-1              1/1     Running   0          7s    10.244.0.228   minikube   <none>           <none>
pod/persistence-postgresql-ha-postgresql-2              1/1     Running   0          7s    10.244.0.227   minikube   <none>           <none>
```

### Verify if database was created

We had specified a initial database to be created in our `custom-values.yaml` file, so to verify if the database was created we can run following commands.

```sh
export POSTGRES_PASSWORD=$(kubectl get secret --namespace ha-db persistence-postgresql-ha-postgresql -o jsonpath="{.data.password}" | base64 -d)
export REPMGR_PASSWORD=$(kubectl get secret --namespace ha-db persistence-postgresql-ha-postgresql -o jsonpath="{.data.repmgr-password}" | base64 -d)

kubectl run persistence-postgresql-ha-client --rm --tty -i --restart='Never' --namespace ha-db --image docker.io/bitnami/postgresql-repmgr:15.3.0-debian-11-r16 --env="PGPASSWORD=$POSTGRES_PASSWORD"  \
        --command -- psql -h persistence-postgresql-ha-pgpool -p 5432 -U dbuser -d keycloak_db
```

Once the above commands are run we will see a list of databases available in our PostgreSQL instance. Here the output shows we have been able to create `keycloak_db` and `repmgr` databases as specified in our `custom-values.yaml` file.

```sh
If you don't see a command prompt, try pressing enter.

keycloak_db=> \l

                                                  List of databases
    Name     |  Owner   | Encoding |   Collate   |    Ctype    | ICU Locale | Locale Provider |   Access privileges   
-------------+----------+----------+-------------+-------------+------------+-----------------+-----------------------
 keycloak_db | dbuser   | UTF8     | en_US.UTF-8 | en_US.UTF-8 |            | libc            | =Tc/dbuser           +
             |          |          |             |             |            |                 | dbuser=CTc/dbuser
 postgres    | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |            | libc            | 
 repmgr      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |            | libc            | 
 template0   | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |            | libc            | =c/postgres          +
             |          |          |             |             |            |                 | postgres=CTc/postgres
 template1   | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |            | libc            | =c/postgres          +
             |          |          |             |             |            |                 | postgres=CTc/postgres
(5 rows)
```

Further we can verify if required user roles were created based on values provided in `custom-values.yaml` file by running following command:

```sh
keycloak_db=> \du
```

Here we see `dbuser` and `dbrepmgr` roles have been created.

```sh

                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 dbrepmgr  | Superuser, Replication                                     | {}
 dbuser    | Create DB                                                  | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

```

## Using PostgreSQL HA as external database

### Creating a custom namespace for Keycloak

We will install the HCL DS Keycloak service through helm to match the PostgreSQL installation. We will install the service into the `hclds` namespace for separation of concerns. For this we will first create it by running the following command:

```sh
kubectl create ns hclds
```

Once the namespace is created we will see following output:

```sh
namespace/hclds created
```

### Overriding values in the helm chart

We need to override certain values before we install the helm chart provided. This can be done by creating a `custom-values.yaml` file that can have values we want to override.

For creating the custom values file we run following command:

```sh
vi custom-values.yaml
```

Once the editor opens paste below contents in the `custom-values.yaml` file and save it.

```yaml
# Do not deploy own postgres; we will use an existing database we created above.
postgresql:
  enabled: false

# enable production mode
production: true

# production mode requires TLS to be set to true
tls:
  enabled: true

# connect to PostgreSQL HA instance for persistence
externalDatabase:
  host: "persistence-postgresql-ha-pgpool.ha-db.svc.cluster.local"
  port: 5432
  user: dbuser
  database: keycloak_db
  password: password
```

### Running helm install

With the above configuration, we are all set and can now install the Keycloak service. To do so, go to the helm chart at [deployment/helm/hclds-keycloak](../../../deployment/helm/hclds-keycloak/) and run:

```console
helm install --values custom-values.yaml -n hclds keycloak .
```

For more details on the installation steps please refer to the [Installation](../../install.md) section.
