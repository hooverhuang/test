# MinIO
MinIO is a high-performance, distributed object storage system designed for cloud-native applications and data-intensive workloads. It provides a scalable and cost-effective solution for storing and accessing large amounts of unstructured data, such as images, videos, and documents. With its compatibility with the Amazon S3 API, MinIO enables seamless integration with existing S3-compatible applications and tools. Its decentralized architecture allows for easy deployment on commodity hardware and provides fault tolerance and data resilience. MinIO offers a user-friendly web-based management console and supports advanced features like data encryption, access control policies, and versioning.

## Requirments
1. Kubenetes 1.25+ or Rancher 2.7.3+
2. Done of StorageClass and PersistentVolumeClaim preparation

## How to deploy
In the installation page where you will find different tabs for configuration. In the following section, we will provide a introduction to the settings required on some tab:
### Service
To expose Minio to the Internet and provide external access, we have two options for the service type: LoadBalancer and NodePort :

- **LoadBalancer** : you should configure a Load Balancer IP from the VIP (Virtual IP) address pool. This IP will be used to route external traffic to Minio.
- **NodePort** : you can configure a specific port number. If no port is configured, a random port will be assigned automatically.
<br>


### Advanced Setting
If you want to set advanced settings, you can edit values.yaml. The following tables lists the configurable parameters of the Minio chart and their default values.       
#### Minio Configuration parameters
| Variable | Description | Default |
| :------- | :---------- | :------ |
| `nameOverride` |  Override the name of the chart. | `""`  |
| `fullnameOverride` |  Override the full name of the chart. | `""`  |
| `clusterDomain` |  The domain name for the Kubernetes cluster. | `cluster.local` |
| `image.repository` |  The repository for the MinIO image. | `quay.io/minio/minio` |
| `image.tag` |  The tag for the MinIO image. | `RELEASE.2023-06-19T19-52-50Z` |
| `image.pullPolicy` |  The image pull policy. | `IfNotPresent` |
| `imagePullSecrets` |  List of secrets to use for pulling images. | `[]` |
| `mcImage.repository` |  The repository for the `mc` image (MinIO client). | `quay.io/minio/mc` |
| `mcImage.tag` |  The tag for the `mc` image. | `RELEASE.2023-06-19T19-31-19Z` |
| `mcImage.pullPolicy` |  The `mc` image pull policy. | `IfNotPresent` |
| `mode` |  The deployment mode for MinIO. | `standalone` |
| `ignoreChartChecksums` |  A boolean value indicating whether to ignore chart checksums. | `False` |
| `extraArgs` |  Additional arguments to pass to the MinIO container. | `[]` |
| `extraVolumes` |  Additional volumes to mount in the MinIO pod. | `[]` |
| `extraVolumeMounts` |  Additional volume mounts in the MinIO container. | `[]` |
| `extraContainers` |  Additional sidecar containers to run alongside MinIO. | `[]` |
| `minioAPIPort` |  The port number for the MinIO API. | `9000` |
| `minioConsolePort` |  The port number for the MinIO console. | `9001` |
| `deploymentUpdate.type` |  The update strategy for the MinIO Deployment. | `RollingUpdate` |
| `deploymentUpdate.maxUnavailable` |  The maximum number of unavailable pods during an update. | `0` |
| `deploymentUpdate.maxSurge` |  The maximum number of new pods that can be created during an update. | `100%` |
| `statefulSetUpdate.updateStrategy` |  The update strategy for the MinIO StatefulSet. | `RollingUpdate` |
| `priorityClassName` |  The priority class name for the MinIO pods. | `""`  |
| `runtimeClassName` |  The runtime class name for the MinIO pods. | `""`  |
| `rootUser` |  The username for the MinIO root user. | `admin` |
| `rootPassword` |  The password for the MinIO root user. | `admin123` |
| `existingSecret` |  Name of an existing Secret that contains MinIO credentials. | `""`  |
| `certsPath` |  The path for MinIO TLS certificates. | `/etc/minio/certs/` |
| `configPathmc` |  The path for MinIO client (`mc`) configuration. | `/etc/minio/mc/` |
| `mountPath` |  The mount path for MinIO data storage. | `/export` |
| `bucketRoot` |  The root directory for MinIO buckets. | `""`  |
| `drivesPerNode` |  The number of drives per MinIO node. | `1` |
| `replicas` |  The number of MinIO replicas (for distributed mode). | `1` |
| `pools` |  The number of MinIO storage pools (for erasure coding). | `1` |
| `tls.enabled` |  A boolean value indicating whether to enable TLS for MinIO. | `False` |
| `tls.certSecret` |  Name of a Secret that contains TLS certificate and private key for MinIO. | `""`  |
| `tls.publicCrt` |  The filename of the TLS public certificate. | `public.crt` |
| `tls.privateKey` |  The filename of the TLS private key. | `private.key` |
| `tls.trustedCertsSecret` |  Name of the Secret that contains trusted TLS certificates. | `""`  |
| `selfsigned.enabled` |  Specifies whether to use self-signed TLS certificates. | `False` |
| `selfsigned.certSecret` |  Name of the Secret that contains the self-signed TLS certificate. | `""`  |
| `selfsigned.publicCrt` |  The filename of the self-signed TLS public certificate. | `tls.crt` |
| `selfsigned.privateKey` |  The filename of the self-signed TLS private key. | `tls.key` |
| `selfsigned.trustedCertsSecret` |  Name of the Secret that contains trusted self-signed certificates. | `""`  |
| `persistence.enabled` |  Specifies whether to enable persistent storage for MinIO. | `True` |
| `persistence.existingClaim` |  Name of an existing PersistentVolumeClaim to use. | `""`  |
| `persistence.storageClass` |  Name of the StorageClass to use for dynamic provisioning. | `""`  |
| `persistence.volumeName` |  Name of an existing PersistentVolume to use. | `""`  |
| `persistence.accessMode` |  Access mode for the PersistentVolumeClaim. | `ReadWriteOnce` |
| `persistence.size` |  Size of the PersistentVolumeClaim. | `10Gi` |
| `persistence.subPath` |  Subpath within the PersistentVolume to mount. | `""`  |
| `api.service.type` |  Type of service for the MinIO API server. | `LoadBalancer` |
| `api.service.clusterIP` |  Cluster IP address for the MinIO API service. | `None` |
| `api.service.port` |  Port number for the MinIO API service. | `9000` |
| `api.service.nodePort` |  NodePort for the MinIO API service. | `32000` |
| `api.service.loadBalancerIP` |  IP address for the load balancer. | `None` |
| `api.service.externalIPs` |  List of external IP addresses for the MinIO API service. | `[]` |
| `api.ingress.enabled` |  Specifies whether to enable Ingress for the MinIO API. | `False` |
| `api.ingress.ingressClassName` |  Name of the Ingress class for the MinIO API Ingress. | `None` |
| `api.ingress.path` |  Path for the MinIO API Ingress. | `/` |
| `api.ingress.hosts.host` |  Hostname for the MinIO API Ingress. | `minio.k8s.local` |
| `api.ingress.hosts.extraHosts` |  Additional hostnames for the MinIO API Ingress. | `[]` |
| `api.ingress.tls.defaultSelfSignedCert` |  Specifies whether to use a default self-signed TLS certificate for the MinIO API Ingress. | `True` |
| `api.ingress.tls.tls` |  List of TLS certificates for the MinIO API Ingress. | `[]` |
| `console.service.name` |  Name of the MinIO console service. | `minio-console` |
| `console.service.type` |  Type of service for the MinIO console. | `LoadBalancer` |
| `console.service.clusterIP` |  Cluster IP address for the MinIO console service. | `None` |
| `console.service.port` |  Port number for the MinIO console service. | `9001` |
| `console.service.nodePort` |  NodePort for the MinIO console service. | `32001` |
| `console.service.loadBalancerIP` |  IP address for the load balancer. | `None` |
| `console.service.externalIPs` |  List of external IP addresses for the MinIO console service. | `[]` |
| `console.service.vipSharingEnabled` |  Specifies whether to enable VIP sharing for the MinIO console service. | `False` |
| `console.service.dnsEnabled` |  Specifies whether to enable DNS for the MinIO console service. | `False` |
| `console.service.hostname` |  Hostname for the MinIO console service. | `minio-console.default.k8s.local` |
| `console.ingress.enabled` |  Specifies whether to enable Ingress for the MinIO console. | `False` |
| `console.ingress.ingressClassName` |  Name of the Ingress class for the MinIO console Ingress. | `None` |
| `console.ingress.path` |  Path for the MinIO console Ingress. | `/` |
| `console.ingress.hosts.host` |  Hostname for the MinIO console Ingress. | `minio-console.k8s.local` |
| `console.ingress.hosts.extraHosts` |  Additional hostnames for the MinIO console Ingress. | `[]` |
| `console.ingress.tls.defaultSelfSignedCert` |  Specifies whether to use a default self-signed TLS certificate for the MinIO console Ingress. | `True` |
| `console.ingress.tls.tls` |  List of TLS certificates for the MinIO console Ingress. | `[]` |
| `tolerations` |  List of tolerations for the MinIO Pods. | `[]` |
| `topologySpreadConstraints` |  List of topology spread constraints for the MinIO Pods. | `[]` |
| `securityContext.enabled` |  Specifies whether to enable security context for the MinIO Pods. | `True` |
| `securityContext.runAsUser` |  User ID to run the MinIO Pods as. | `1000` |
| `securityContext.runAsGroup` |  Group ID to run the MinIO Pods as. | `1000` |
| `securityContext.fsGroup` |  Group ID for the file system access of the MinIO Pods. | `1000` |
| `securityContext.fsGroupChangePolicy` |  Policy for changing the file system group ID. | `OnRootMismatch` |
| `resources.requests.memory` |  Memory request for the MinIO Pods. | `1Gi` |
| `selfSignedJob.image.repository` |  Image repository for the self-signed certificate job. | `alpine/k8s` |
| `selfSignedJob.image.tag` |  Image tag for the self-signed certificate job. | `1.25.6` |
| `selfSignedJob.image.pullPolicy` |  Pull policy for the self-signed certificate job. | `IfNotPresent` |
| `selfSignedJob.securityContext.enabled` |  Specifies whether to enable security context for the self-signed certificate job. | `True` |
| `selfSignedJob.securityContext.runAsUser` |  User ID to run the self-signed certificate job as. | `1000` |
| `selfSignedJob.securityContext.runAsGroup` |  Group ID to run the self-signed certificate job as. | `1000` |
| `selfSignedJob.securityContext.fsGroup` |  Group ID for the file system access of the self-signed certificate job. | `1000` |
| `selfSignedJob.tolerations` |  List of tolerations for the self-signed certificate job. | `[]` |
| `selfSignedJob.serviceAccount.create` |  Specifies whether to create a service account for the self-signed certificate job. | `True` |
| `postJob.securityContext.enabled` |  Specifies whether to enable security context for the post-installation job. | `True` |
| `postJob.securityContext.runAsUser` |  User ID to run the post-installation job as. | `1000` |
| `postJob.securityContext.runAsGroup` |  Group ID to run the post-installation job as. | `1000` |
| `postJob.securityContext.fsGroup` |  Group ID for the file system access of the post-installation job. | `1000` |
| `postJob.tolerations` |  List of tolerations for the post-installation job. | `[]` |
| `postJob.makePolicy.securityContext.enabled` |  Specifies whether to enable security context for the make policy job. | `True` |
| `postJob.makePolicy.securityContext.runAsUser` |  User ID to run the make policy job as. | `1000` |
| `postJob.makePolicy.securityContext.runAsGroup` |  Group ID to run the make policy job as. | `1000` |
| `postJob.makePolicy.resources.requests.memory` |  Memory request for the make policy job. | `128Mi` |
| `postJob.makePolicy.exitCommand` |  Command to execute upon completion of the make policy job. | `""`  |
| `postJob.makeUser.securityContext.enabled` |  Specifies whether to enable security context for the make user job. | `True` |
| `postJob.makeUser.securityContext.runAsUser` |  User ID to run the make user job as. | `1000` |
| `postJob.makeUser.securityContext.runAsGroup` |  Group ID to run the make user job as. | `1000` |
| `postJob.makeUser.resources.requests.memory` |  Memory request for the make user job. | `128Mi` |
| `postJob.makeUser.exitCommand` |  Command to execute upon completion of the make user job. | `""`  |
| `postJob.makeServiceAccount.securityContext.enabled` |  Specifies whether to enable security context for the make service account job. | `True` |
| `postJob.makeServiceAccount.securityContext.runAsUser` |  User ID to run the make service account job as. | `1000` |
| `postJob.makeServiceAccount.securityContext.runAsGroup` |  Group ID to run the make service account job as. | `1000` |
| `postJob.makeServiceAccount.resources.requests.memory` |  Memory request for the make service account job. | `128Mi` |
| `postJob.makeServiceAccount.exitCommand` |  Command to execute upon completion of the make service account job. | `""`  |
| `postJob.makeBucket.securityContext.enabled` |  Specifies whether to enable security context for the make bucket job. | `True` |
| `postJob.makeBucket.securityContext.runAsUser` |  User ID to run the make bucket job as. | `1000` |
| `postJob.makeBucket.securityContext.runAsGroup` |  Group ID to run the make bucket job
| `postJob.makeBucket.exitCommand` |  Command to execute upon completion of the make bucket job. | `""`  |
| `postJob.customCommandJob.securityContext.enabled` |  Specifies whether to enable security context for the custom command job. | `True` |
| `postJob.customCommandJob.securityContext.runAsUser` |  User ID to run the custom command job as. | `1000` |
| `postJob.customCommandJob.securityContext.runAsGroup` |  Group ID to run the custom command job as. | `1000` |
| `postJob.customCommandJob.resources.requests.memory` |  Memory request for the custom command job. | `128Mi` |
| `postJob.customCommandJob.exitCommand` |  Command to execute upon completion of the custom command job. | `""`  |
| `defaulSetting.svcacct.enabled` |  Specifies whether to enable default service account creation. | `True` |
| `defaulSetting.bucket.enabled` |  Specifies whether to enable default bucket creation. | `True` |
| `defaulSetting.bucket.name` |  Name of the default bucket to create. | `mybucket` |
| `defaulSetting.bucket.policy` |  Policy for the default bucket. | `none` |
| `defaulSetting.bucket.purge` |  Specifies whether to enable purging of the default bucket. | `False` |
| `defaulSetting.bucket.versioning` |  Specifies whether to enable versioning for the default bucket. | `False` |
| `defaulSetting.bucket.objectlocking` |  Specifies whether to enable object locking for the default bucket. | `False` |
| `policies` |  List of custom policies for MinIO users. | `[]` |
| `users` |  List of MinIO users and their access keys. | `[{'accessKey': 'console', 'secretKey': 'console123', 'policy': 'consoleAdmin'}]` |
| `svcaccts` |  List of additional service accounts to create. | `[]` |
| `buckets` |  List of additional buckets to create. | `[]` |
| `customCommands` |  Custom commands to execute during MinIO startup. | `None` |
| `environment` |  Additional environment variables for the MinIO Pods. | `None` |
| `extraSecret` |  Additional secret data for the MinIO Pods. | `None` |
| `oidc.enabled` |  Specifies whether to enable OIDC (OpenID Connect) for MinIO authentication. | `False` |
| `oidc.configUrl` |  URL of the OIDC provider's configuration endpoint. | `https://identity-provider-url/.well-known/openid-configuration` |
| `oidc.clientId` |  Client ID for OIDC authentication. | `minio` |
| `oidc.clientSecret` |  Client secret for OIDC authentication. | `""`  |
| `oidc.claimName` |  Name of the claim to use for MinIO user policy. | `policy` |
| `oidc.scopes` |  Scopes to request during OIDC authentication. | `openid,profile,email` |
| `oidc.redirectUri` |  Redirect URI for OIDC authentication callback. | `https://console-endpoint-url/oauth_callback` |
| `oidc.claimPrefix` |  Prefix to add to OIDC claim names in MinIO user policy. | `""`  |
| `oidc.comment` |  Comment for OIDC configuration. | `""`  |
| `networkPolicy.enabled` |  Specifies whether to enable network policies for MinIO Pods. | `False` |
| `networkPolicy.allowExternal` |  Specifies whether to allow external traffic in network policies. | `True` |
| `podDisruptionBudget.enabled` |  Specifies whether to enable Pod Disruption Budget (PDB) for MinIO Pods. | `False` |
| `podDisruptionBudget.maxUnavailable` |  Maximum number of MinIO Pods that can be unavailable during updates. | `1` |
| `serviceAccount.create` |  Specifies whether to create a service account for MinIO Pods. | `True` |
| `serviceAccount.name` |  Name of the service account for MinIO Pods. | `minio
