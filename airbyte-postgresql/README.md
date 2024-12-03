# PostgreSQL

PostgreSQL is a powerful open-source relational database management system. It is known for its robustness, scalability, and extensive feature set. PostgreSQL supports ACID transactions, provides excellent data integrity, and offers advanced capabilities such as complex queries, indexing, and JSON support. With its active community and frequent updates, PostgreSQL has become a popular choice for various applications, ranging from small projects to large enterprise systems, seeking a reliable and feature-rich database solution.

## Requirments
1. Kubenetes 1.25+ or Rancher 2.7.3+
2. Done of StorageClass and PersistentVolumeClaim preparation

## How to deploy
In the installation page where you will find different tabs for configuration. In the following section, we will provide a introduction to the settings required on some tab:


### Service
To expose PostgreSQL to the Internet and provide external access, we have two options for the service type: LoadBalancer and NodePort :

- **LoadBalancer** : you should configure a Load Balancer IP from the VIP (Virtual IP) address pool. This IP will be used to route external traffic to PostgreSQL.
- **NodePort** : you can configure a specific port number. If no port is configured, a random port will be assigned automatically.
<br>
Note: When you configure service type as ClusterIP, you can expose Kibana to the Internet with ingress setting.

<br>

### Advanced Setting
If you want to set advanced settings, you can edit values.yaml. The following tables lists the configurable parameters of the PostgreSQL chart and their default values.

#### PostgreSQL Configuration parameters
| Variable                                                           | Description                                                                   | Default                   |
| :----------------------------------------------------------------- | :---------------------------------------------------------------------------- | :------------------------ |
|`global.imagePullSecrets`|Global Docker registry secret names as an array|`[]`|
|`global.nameOverride`| String to partially override postgresql.name template (will maintain the release name)|`""`|
|`global.fullnameOverride`|String to fully override postgresql.fullname template|`""`|
|`serviceAccount.create`|Enable creation of ServiceAccount for PostgreSQL pod|`true`|
|`serviceAccount.annotations`|Additional custom annotations for the ServiceAccount|`{}`|
|`serviceAccount.name`|The name of the ServiceAccount to use.|`""`|
|`ingress.enabled`|Enable PostgreSQL ingress|`false`|
|`ingress.className`|Ingress class name that PostgreSQL is using|`""`|
|`ingress.annotations`|Additional custom annotations for the Ingress|`{}`|
|`ingress.hosts`|Ingress host setting||
|`ingress.tls`|Ingress tls setting|`[]`|
|`postgresql.image.repository`|PostgreSQL image repository|`postgres`|
|`postgresql.image.pullPolicy`|PostgreSQL image pullPolicy |`IfNotPresent`|
|`postgresql.image.tag`|PostgreSQL image tag|`14.2`|
|`postgresql.podAnnotations`|Map of annotations to add to the pods|`{}`|
|`postgresql.podSecurityContext.fsGroup`|Group ID for the pod|`999`|
|`postgresql.securityContext.capabilities.drop`|Allows you to specify the privileged capabilities that should be dropped when running a container.|`['ALL']`|
|`postgresql.securityContext.readOnlyRootFilesystem`|Attribute used for container security. When set to true, it instructs the container's root filesystem to be mounted in read-only mode, preventing any processes within the container from making write operations to the root filesystem.|`true`|
|`postgresql.securityContext.runAsNonRoot`|Set PostgreSQL container's Security Context runAsNonRoot|`true`|
|`postgresql.securityContext.runAsUser`|Set PostgreSQL container's Security Context runAsUser|`999`|
|`postgresql.ports.http.name`|PostgreSQL container port name|`http`|
|`postgresql.ports.http.number`|PostgreSQL container port number|`5432`|
|`postgresql.env`|Environment variables add to PostgreSQL|`["POSTGRES_USER":"infortrend","POSTGRES_PASSWORD":"infortrend"]`|
|`postgresql.volumeMounts`|Volume Mounts Information to PostgreSQL|`[{"name":"data-pvc","mountPath":"/var/lib/postgresql/data"},{"name":"run-postgres","mountPath":"/var/run/postgresql"}]`|
|`postgresql.volumeClaimTemplates`|PostgreSQL volume claim template|`{}`|
|`postgresql.service.name`|PostgreSQL serivce name|`""`|
|`postgresql.service.type`|PostgreSQL service type|`LoadBalancer`|
|`postgresql.service.clusterIP`|PostgreSQL clusterIP|`None`|
|`postgresql.service.port`|PostgreSQL serivce port number|`5432`|
|`postgresql.service.targetPort`|PostgreSQL serivce target port number|`5432`|
|`postgresql.service.nodePort`|PostgreSQL serivce nodePort number|`""`|
|`postgresql.service.portname`|PostgreSQL serivce port name|`postgresql-http`|
|`postgresql.service.protocol`|PostgreSQL serivce protocol|`TCP`|
|`postgresql.service.loadbalancerip`|LoadBalancer will get created with the IP specified in this field|`""`|
|`postgresql.service.vipSharingEnabled`|Service static VIP shares if using loadBalancer mode|`false`|
|`postgresql.service.dnsEnabled`|Export hostname to external dns|`false`|
|`postgresql.service.hostname`|Hostname for exporting if service.dnsEnabled is true|`postgresql.default.k8s.local`|
|`postgresql.service.annotations`|Annotations for PostgreSQL serivce|`{}`|
|`postgresql.minReadySeconds`|Attribute used in the Deployment resource to specify the minimum amount of time in seconds that a newly created or updated Pod needs to be ready.|`10`|
|`postgresql.resources.limits.cpu`|PostgreSQL CPU resource upper bound|`2000m`|
|`postgresql.resources.limits.memory`|PostgreSQL memory resource upper bound||
|`postgresql.resources.requests.cpu`|PostgreSQL CPU resource lower bound|`250m`|
|`postgresql.resources.requests.memory`|PostgreSQL memory resource lower bound|`256Mi`|
|`postgresql.autoscaling.enabled`|Enable Horizontal Pod Autoscaler|`false`|
|`postgresql.autoscaling.minReplicas`|Minimum number of replicas for the HPA|`1`|
|`postgresql.autoscaling.maxReplicas`|Maximum number of replicas for the HPA|`100`|
|`postgresql.autoscaling.targetCPUUtilizationPercentage`|Average CPU utilization percentage for the HPA|`80`|
|`postgresql.nodeSelector`|Node labels for PostgreSQL|`{}`|
|`postgresql.tolerations`|Tolerations for PostgreSQL|`[]`|
|`postgresql.affinity`|Affinity for PostgreSQL|`{}`|