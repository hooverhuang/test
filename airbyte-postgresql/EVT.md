# PostgreSQL

PostgresSQL service has several schemes/types:

1. `ClusterIP`: If this type of the service is used for wrapping the Pods, Deployments, or the StatefulSets, the service can only be accessed by the other Pods, Deployments, or StatefulSets which are in the same namespace on the cluster.

2. `NodePort`: Using `NodePort` type service allows users to connect it from outside the cluster by `ANY_WORKERNODE_IP:NODEPORTNUMBER`. But there is a problem, if the worker node whose IP is `ANY_WORKERNODE_IP` get an unexpected error that makes it offline, then users will fail to connect to the application by using `ANY_WORKERNODE_IP`.

3. `LoadBalancer`: Using `LoadBalancer` type service combine an outside load balancer will gives the application a virtual IP let users connect it. The benefit is any worker nodes failed would not effect the connection because of it is virtual IP. The disadvantage is needs to use a outside load balancer, In the Infortrend case, we use MetaLB as the load balancer.


## How to connect to the PostgreSQL

Because there are 3 service types, we describe each scheme to connect to the PostgreSQL server.

**NOTICE:**
1. Default PostgreSQL `username/password`: `infortrend/infortrend`
2. PostgreSQL in Redmine `username/password`: `redmine/secret`

### ClusterIP

1. Get into `racher-cmd` console

2. Deploy an another PostgreSQL application in the same namespace on the cluster: `kubectl run pgdbconnecttest --image=postgres:14.2 --port=5432 -it --kubeconfig=YOUR_CLUSTER_CONFIG_PATH bash`

3. After step 2, you will get into `pgdbconnecttest` console. then type: `psql -h YOUR_POSTGRESQL_SERVICE_NAME -U YOUR_POSTGRESQL_USERNAME -c "\l+"` to list all databases in the remote PostgreSQL server.

4. Create a database: 

    * `psql -h YOUR_POSTGRESQL_SERVICE_NAME -U YOUR_POSTGRESQL_USERNAME -c "\CREATE DATABASE YOUR_DATABASE_NAME;"`

    * Use step 3 command to check the database creation successfully.

5. Back to the cluster, get into the PostgreSQL server and use step 3 command to check the database existed. 

**If both step 4 and 5 succeed, then the connection is successful.**

### NodePort

1. Get into `racher-cmd` console

2. Deploy an another PostgreSQL application outside the cluster:

    * Deploy an another PostgreSQL application on the other cluster: `kubectl run pgdbconnecttest --image=postgres:14.2 --port=5432 -it --kubeconfig=ANOTHER_CLUSTER_CONFIG_PATH bash`

    * Deploy an another PostgreSQL application on an another device using docker: `docker run -it --rm --name pgdbconnecttest postgres:14.2 bash`

3. After step 2, you will get into `pgdbconnecttest` console. then type: `psql -h YOUR_POSTGRESQL_CLUSTER_WORKERNODE_IP -p NODEPORT_NUMBER -U YOUR_POSTGRESQL_USERNAME -c "\l+"` to list all databases in the remote PostgreSQL server.

4. Create a database: 
    * `psql -h YOUR_POSTGRESQL_CLUSTER_WORKERNODE_IP -p NODEPORT_NUMBER -U YOUR_POSTGRESQL_USERNAME -c "\CREATE DATABASE YOUR_DATABASE_NAME;"`

    * Use step 3 command to check the database creation successfully.

5. Back to the cluster, get into the PostgreSQL server and use step 3 command to check the database existed. 

**If both step 4 and 5 succeed, then the connection is successful.**

### LoadBalancer

1. Get into `racher-cmd` console

2. Check Virtual IP: Move the mouse to the link, the virtual IP and port number will show at the left bottom of the browser screen.

3. Deploy an another PostgreSQL application outside the cluster:

    * Deploy an another PostgreSQL application on the other cluster: `kubectl run pgdbconnecttest --image=postgres:14.2 --port=5432 -it --kubeconfig=ANOTHER_CLUSTER_CONFIG_PATH bash`

    * Deploy an another PostgreSQL application on an another device using docker: `docker run -it --rm --name pgdbconnecttest postgres:14.2 bash`

4. After step 2, you will get into `pgdbconnecttest` console. then type: `psql -h YOUR_POSTGRESQL_CLUSTER_WORKERNODE_IP -p NODEPORT_NUMBER -U YOUR_POSTGRESQL_USERNAME -c "\l+"` to list all databases in the remote PostgreSQL server.

5. Create a database: 

    * `psql -h YOUR_POSTGRESQL_CLUSTER_WORKERNODE_IP -p NODEPORT_NUMBER -U YOUR_POSTGRESQL_USERNAME -c "\CREATE DATABASE YOUR_DATABASE_NAME;"`

    * Use step 3 command to check the database creation successfully.

6. Back to the cluster, get into the PostgreSQL server and use step 3 command to check the database existed. 

**If both step 5 and 6 succeed, then the connection is successful.**