# Values schema documentation

This page lists all available configuration options, based on the [configuration values schema](values.schema.json).

Note that configuration options can change between releases. Use the GitHub function for selecting a branch/tag to view the documentation matching your cluster-aks version.

<!-- Update the content below by executing (from the repo root directory)

make generate-docs

-->

<!-- DOCS_START -->

### Other global

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.managementCluster` |**None**|**Type:** `string`<br/>**Default:** `""`|

### apps
Properties within the `.global.apps` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.apps.azureAksExtras` |**None**|**Type:** `object`<br/>**Default:** `{}`|

### cluster
Properties within the `.cluster` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `cluster.providerIntegration` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certExporter` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certExporter.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.certManager` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certManager.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSCertManagerHelmValues"`|
| `cluster.providerIntegration.apps.certManager.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.chartOperatorExtensions` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.chartOperatorExtensions.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.cilium` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.cilium.enable` |Already managed by AKS|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.ciliumServiceMonitors` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.ciliumServiceMonitors.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.clusterAutoscaler` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.clusterAutoscaler.enable` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.coreDns` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.coreDns.enable` |Already managed by AKS|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.coreDnsExtensions` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.coreDnsExtensions.enable` |Already managed by AKS|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.externalDns` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.externalDns.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSExternalDnsHelmValues"`|
| `cluster.providerIntegration.apps.externalDns.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.k8sDnsNodeCache` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.k8sDnsNodeCache.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.metricsServer` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.metricsServer.enable` |Already managed by AKS|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.netExporter` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.netExporter.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.networkPolicies` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.networkPolicies.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSNetworkPoliciesHelmValues"`|
| `cluster.providerIntegration.apps.networkPolicies.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.nodeExporter` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.nodeExporter.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.observabilityBundle` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.observabilityBundle.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSObservabilityBundleHelmValues"`|
| `cluster.providerIntegration.apps.observabilityBundle.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.observabilityPolicies` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.observabilityPolicies.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.priorityClasses` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.priorityClasses.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.rbacBootstrap` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.rbacBootstrap.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.securityBundle` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.securityBundle.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSSecurityBundleHelmValues"`|
| `cluster.providerIntegration.apps.securityBundle.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.teleportKubeAgent` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.teleportKubeAgent.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSTeleportKubeAgentHelmValues"`|
| `cluster.providerIntegration.apps.teleportKubeAgent.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.verticalPodAutoscaler` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.verticalPodAutoscaler.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSVerticalPodAutoscalerHelmValues"`|
| `cluster.providerIntegration.apps.verticalPodAutoscaler.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.verticalPodAutoscalerCrd` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.verticalPodAutoscalerCrd.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.clusterAnnotationsTemplateName` |Named template (defined in this chart) that renders annotations placed on the Cluster CR by the cluster subchart.|**Type:** `string`<br/>**Default:** `"azureClusterAnnotations"`|
| `cluster.providerIntegration.controlPlane` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.controlPlane.resources` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.controlPlane.resources.controlPlane` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.controlPlane.resources.controlPlane.api` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.controlPlane.resources.controlPlane.api.group` |**None**|**Type:** `string`<br/>**Default:** `"infrastructure.cluster.x-k8s.io"`|
| `cluster.providerIntegration.controlPlane.resources.controlPlane.api.kind` |**None**|**Type:** `string`<br/>**Default:** `"AzureASOManagedControlPlane"`|
| `cluster.providerIntegration.controlPlane.resources.controlPlane.api.version` |**None**|**Type:** `string`<br/>**Default:** `"v1beta1"`|
| `cluster.providerIntegration.controlPlane.resources.infrastructureMachineTemplate` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.controlPlane.resources.infrastructureMachineTemplate.group` |**None**|**Type:** `string`<br/>**Default:** `"infrastructure.cluster.x-k8s.io"`|
| `cluster.providerIntegration.controlPlane.resources.infrastructureMachineTemplate.kind` |**None**|**Type:** `string`<br/>**Default:** `"AzureASOManagedControlPlane"`|
| `cluster.providerIntegration.controlPlane.resources.infrastructureMachineTemplate.version` |**None**|**Type:** `string`<br/>**Default:** `"v1beta1"`|
| `cluster.providerIntegration.controlPlane.resources.infrastructureMachineTemplateSpecTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"noop"`|
| `cluster.providerIntegration.pauseProperties` |**None**|**Type:** `object`<br/>**Default:** `{}`|
| `cluster.providerIntegration.provider` |**None**|**Type:** `string`<br/>**Default:** `"aks"`|
| `cluster.providerIntegration.resourcesApi` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.bastionResourceEnabled` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.resourcesApi.cleanupHelmReleaseResourcesEnabled` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.resourcesApi.clusterResourceEnabled` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.resourcesApi.controlPlaneResource` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.controlPlaneResource.enabled` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.resourcesApi.controlPlaneResource.provider` |**None**|**Type:** `string`<br/>**Default:** `"external"`|
| `cluster.providerIntegration.resourcesApi.helmRepositoryResourcesEnabled` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.resourcesApi.infrastructureCluster` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.infrastructureCluster.group` |**None**|**Type:** `string`<br/>**Default:** `"infrastructure.cluster.x-k8s.io"`|
| `cluster.providerIntegration.resourcesApi.infrastructureCluster.kind` |**None**|**Type:** `string`<br/>**Default:** `"AzureASOManagedCluster"`|
| `cluster.providerIntegration.resourcesApi.infrastructureCluster.version` |**None**|**Type:** `string`<br/>**Default:** `"v1beta1"`|
| `cluster.providerIntegration.resourcesApi.infrastructureMachinePool` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.infrastructureMachinePool.group` |**None**|**Type:** `string`<br/>**Default:** `"infrastructure.cluster.x-k8s.io"`|
| `cluster.providerIntegration.resourcesApi.infrastructureMachinePool.kind` |**None**|**Type:** `string`<br/>**Default:** `"AzureASOManagedMachinePool"`|
| `cluster.providerIntegration.resourcesApi.infrastructureMachinePool.version` |**None**|**Type:** `string`<br/>**Default:** `"v1beta1"`|
| `cluster.providerIntegration.resourcesApi.machineHealthCheckResourceEnabled` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.resourcesApi.machinePool` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.machinePool.bootstrap` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.machinePool.bootstrap.templateName` |**None**|**Type:** `string`<br/>**Default:** `"azureMachinePoolBootstrap"`|
| `cluster.providerIntegration.resourcesApi.machinePoolResources` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.machinePoolResources.enabled` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.resourcesApi.machinePoolResources.externalAutoscaler` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.resourcesApi.machinePoolResources.externalAutoscaler.enabled` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.resourcesApi.nodePoolKind` |**None**|**Type:** `string`<br/>**Default:** `"MachinePool"`|
| `cluster.providerIntegration.useReleases` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.workers` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.workers.defaultNodePools` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.workers.defaultNodePools.system` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.workers.defaultNodePools.system.availabilityZones` |**None**|**Type:** `array`<br/>**Default:** `["1","2","3"]`|
| `cluster.providerIntegration.workers.defaultNodePools.system.availabilityZones[*]` |**None**|**Type:** `string`<br/>|
| `cluster.providerIntegration.workers.defaultNodePools.system.enableAutoScaling` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.workers.defaultNodePools.system.maxSize` |**None**|**Type:** `integer`<br/>**Default:** `2`|
| `cluster.providerIntegration.workers.defaultNodePools.system.minSize` |**None**|**Type:** `integer`<br/>**Default:** `1`|
| `cluster.providerIntegration.workers.defaultNodePools.system.mode` |**None**|**Type:** `string`<br/>**Default:** `"System"`|
| `cluster.providerIntegration.workers.defaultNodePools.system.osDiskSizeGB` |**None**|**Type:** `integer`<br/>**Default:** `128`|
| `cluster.providerIntegration.workers.defaultNodePools.system.osDiskType` |**None**|**Type:** `string`<br/>**Default:** `"Managed"`|
| `cluster.providerIntegration.workers.defaultNodePools.system.osType` |**None**|**Type:** `string`<br/>**Default:** `"Linux"`|
| `cluster.providerIntegration.workers.defaultNodePools.system.vmSize` |**None**|**Type:** `string`<br/>**Default:** `"Standard_D2s_v3"`|
| `cluster.providerIntegration.workers.defaultNodePools.workers` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.workers.defaultNodePools.workers.availabilityZones` |**None**|**Type:** `array`<br/>**Default:** `["1","2","3"]`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.availabilityZones[*]` |**None**|**Type:** `string`<br/>|
| `cluster.providerIntegration.workers.defaultNodePools.workers.enableAutoScaling` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.maxSize` |**None**|**Type:** `integer`<br/>**Default:** `2`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.minSize` |**None**|**Type:** `integer`<br/>**Default:** `1`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.mode` |**None**|**Type:** `string`<br/>**Default:** `"User"`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.osDiskSizeGB` |**None**|**Type:** `integer`<br/>**Default:** `128`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.osDiskType` |**None**|**Type:** `string`<br/>**Default:** `"Managed"`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.osType` |**None**|**Type:** `string`<br/>**Default:** `"Linux"`|
| `cluster.providerIntegration.workers.defaultNodePools.workers.vmSize` |**None**|**Type:** `string`<br/>**Default:** `"Standard_D2s_v3"`|
| `cluster.providerIntegration.workers.kubeadmConfig` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.workers.kubeadmConfig.enabled` |**None**|**Type:** `boolean`<br/>**Default:** `false`|

### connectivity
Properties within the `.global.connectivity` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.connectivity.apiServerAccess` |Optional API server access controls (AKS public/private cluster).|**Type:** `object`<br/>|
| `global.connectivity.apiServerAccess.authorizedIPRanges` |**None**|**Type:** `array`<br/>**Default:** `[]`|
| `global.connectivity.apiServerAccess.authorizedIPRanges[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.apiServerAccess.enablePrivateCluster` |When true, the AKS API server is reachable only from inside the VNet (or via authorizedIPRanges).|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.apiServerAccess.enablePrivateClusterPublicFQDN` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.apiServerAccess.privateDNSZone` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.connectivity.baseDomain` |DNS base domain used by the management cluster's installation|**Type:** `string`<br/>**Default:** `""`|
| `global.connectivity.network` |**None**|**Type:** `object`<br/>|
| `global.connectivity.network.dnsServiceIP` |Must be within the service CIDR.|**Type:** `string`<br/>**Default:** `"172.20.0.10"`|
| `global.connectivity.network.pods` |Pods CIDR — only used by AKS when controlPlane.networking.networkPlugin is kubenet. Ignored for Azure CNI (both node-subnet and overlay modes); in node-subnet mode pods get IPs from vnet.subnet.cidrBlocks. Kept non-empty because the giantswarm/cluster subchart schema requires at least one entry.|**Type:** `object`<br/>|
| `global.connectivity.network.pods.cidrBlocks` |**None**|**Type:** `array`<br/>**Default:** `["192.168.0.0/16"]`|
| `global.connectivity.network.pods.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.services` |Services CIDR — assigned by AKS for Kubernetes Service IPs. Used to populate Cluster.spec.clusterNetwork.services.|**Type:** `object`<br/>|
| `global.connectivity.network.services.cidrBlocks` |**None**|**Type:** `array`<br/>**Default:** `["172.20.0.0/16"]`|
| `global.connectivity.network.services.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.vnet` |VNet for the cluster's node pools. By default the chart creates an Azure VirtualNetwork (via ASO) with one subnet inside it, and wires every node pool to that subnet (Azure CNI node-subnet mode — pods get IPs from the subnet's CIDR). To bring your own VNet, set subnetArmId to the ARM ID of an existing subnet. When set, the chart does NOT create a VNet and every node pool references the provided subnet instead; cidrBlocks, name, and subnet.* are then ignored.|**Type:** `object`<br/>|
| `global.connectivity.network.vnet.cidrBlocks` |CIDR(s) of the chart-created VirtualNetwork's address space.|**Type:** `array`<br/>**Default:** `["10.224.0.0/12"]`|
| `global.connectivity.network.vnet.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.vnet.name` |Name of the chart-created VirtualNetwork. Defaults to the cluster name when empty.|**Type:** `string`<br/>**Default:** `""`|
| `global.connectivity.network.vnet.subnet` |**None**|**Type:** `object`<br/>|
| `global.connectivity.network.vnet.subnet.cidrBlocks` |CIDR of the chart-created subnet. Must lie within vnet.cidrBlocks.|**Type:** `array`<br/>**Default:** `["10.224.0.0/16"]`|
| `global.connectivity.network.vnet.subnet.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.vnet.subnet.name` |Name of the chart-created subnet (Azure resource name).|**Type:** `string`<br/>**Default:** `"nodes"`|
| `global.connectivity.network.vnet.subnetArmId` |ARM ID of an existing subnet to use for all node pools. When set, the chart skips VNet/Subnet creation. Format: /subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet>/subnets/<subnet>|**Type:** `string`<br/>**Default:** `""`|

### controlPlane
Properties within the `.global.controlPlane` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.controlPlane.aadProfile` |AAD integration. When managed: true, AKS uses AAD for Kubernetes API authentication.|**Type:** `object`<br/>|
| `global.controlPlane.aadProfile.adminGroupObjectIDs` |**None**|**Type:** `array`<br/>|
| `global.controlPlane.aadProfile.adminGroupObjectIDs[*]` |**None**|**Type:** `string`<br/>|
| `global.controlPlane.aadProfile.managed` |**None**|**Type:** `boolean`<br/>|
| `global.controlPlane.additionalTags` |Additional Azure tags applied to the underlying AKS resources.|**Type:** `object`<br/>**Default:** `{}`|
| `global.controlPlane.additionalTags.*` |**None**|**Type:** `string`<br/>|
| `global.controlPlane.autoUpgradeChannel` |**None**|**Type:** `string`<br/>**Allowed values:** `none`, `patch`, `rapid`, `stable`, `node-image`<br/>**Default:** `"none"`|
| `global.controlPlane.dnsPrefix` |DNS prefix. Defaults to the cluster name when empty.|**Type:** `string`<br/>**Default:** `""`|
| `global.controlPlane.networking` |AKS networking.|**Type:** `object`<br/>|
| `global.controlPlane.networking.networkDataplane` |**None**|**Type:** `string`<br/>**Allowed values:** `azure`, `cilium`<br/>**Default:** `"cilium"`|
| `global.controlPlane.networking.networkMode` |**None**|**Type:** `string`<br/>**Allowed values:** `bridge`, `transparent`<br/>**Default:** `"transparent"`|
| `global.controlPlane.networking.networkPlugin` |**None**|**Type:** `string`<br/>**Allowed values:** `azure`, `kubenet`<br/>**Default:** `"azure"`|
| `global.controlPlane.networking.networkPolicy` |**None**|**Type:** `string`<br/>**Allowed values:** `azure`, `calico`, `cilium`, `none`<br/>**Default:** `"cilium"`|
| `global.controlPlane.networking.outboundType` |**None**|**Type:** `string`<br/>**Allowed values:** `loadBalancer`, `managedNATGateway`, `userAssignedNATGateway`, `userDefinedRouting`<br/>**Default:** `"loadBalancer"`|
| `global.controlPlane.sku` |AKS SKU tier.|**Type:** `object`<br/>|
| `global.controlPlane.sku.tier` |**None**|**Type:** `string`<br/>**Allowed values:** `Free`, `Premium`, `Standard`<br/>**Default:** `"Standard"`|

### internal
Properties within the `.internal` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `internal.defaults` |**None**|**Type:** `object`<br/>|
| `internal.defaults.evictionMinimumReclaim` |**None**|**Type:** `string`<br/>**Default:** `"imagefs.available=5%,memory.available=100Mi,nodefs.available=5%"`|
| `internal.defaults.hardEvictionThresholds` |**None**|**Type:** `string`<br/>**Default:** `"memory.available\u003c200Mi,nodefs.available\u003c10%,nodefs.inodesFree\u003c3%,imagefs.available\u003c10%,pid.available\u003c20%"`|
| `internal.defaults.softEvictionGracePeriod` |**None**|**Type:** `string`<br/>**Default:** `"memory.available=30s,nodefs.available=2m,nodefs.inodesFree=1m,imagefs.available=2m,pid.available=1m"`|
| `internal.defaults.softEvictionThresholds` |**None**|**Type:** `string`<br/>**Default:** `"memory.available\u003c500Mi,nodefs.available\u003c15%,nodefs.inodesFree\u003c5%,imagefs.available\u003c15%,pid.available\u003c30%"`|
| `internal.enableVpaResources` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.kubectlImage` |**None**|**Type:** `object`<br/>|
| `internal.kubectlImage.name` |**None**|**Type:** `string`<br/>**Default:** `"giantswarm/docker-kubectl"`|
| `internal.kubectlImage.registry` |**None**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.kubectlImage.tag` |**None**|**Type:** `string`<br/>**Default:** `"1.36.1"`|
| `internal.network` |**None**|**Type:** `object`<br/>|
| `internal.network.vnet` |**None**|**Type:** `object`<br/>**Default:** `{}`|
| `internal.network.vpn` |**None**|**Type:** `object`<br/>|
| `internal.network.vpn.gatewayMode` |**None**|**Type:** `string`<br/>**Default:** `"none"`|
| `internal.sandboxContainerImage` |**None**|**Type:** `object`<br/>|
| `internal.sandboxContainerImage.name` |**None**|**Type:** `string`<br/>**Default:** `"giantswarm/pause"`|
| `internal.sandboxContainerImage.registry` |**None**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.sandboxContainerImage.tag` |**None**|**Type:** `string`<br/>**Default:** `"3.9"`|
| `internal.teleport` |**None**|**Type:** `object`<br/>|
| `internal.teleport.enabled` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.teleport.proxyAddr` |**None**|**Type:** `string`<br/>**Default:** `"teleport.giantswarm.io:443"`|
| `internal.teleport.version` |**None**|**Type:** `string`<br/>**Default:** `"14.1.3"`|

### metadata
Properties within the `.global.metadata` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.metadata.annotations` |**None**|**Type:** `object`<br/>**Default:** `{}`|
| `global.metadata.description` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.metadata.labels` |**None**|**Type:** `object`<br/>**Default:** `{}`|
| `global.metadata.name` |Name of the workload cluster. Defaults to the Helm release name when unset. Must comply with Azure resource naming rules.|**Type:** `string`<br/>**Default:** `""`|
| `global.metadata.organization` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.metadata.preventDeletion` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.metadata.servicePriority` |**None**|**Type:** `string`<br/>**Allowed values:** `lowest`, `medium`, `highest`<br/>**Default:** `"highest"`|

### nodePools
Properties within the `.global.nodePools` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.nodePools.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.additionalTags` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.additionalTags.*` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.availabilityZones` |**None**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.availabilityZones[*]` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.enableAutoScaling` |**None**|**Type:** `boolean`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Default:** `true`|
| `global.nodePools.PATTERN.maxPods` |**None**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.maxSize` |**None**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.minSize` |**None**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.mode` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Allowed values:** `System`, `User`<br/>**Default:** `"User"`|
| `global.nodePools.PATTERN.nodeLabels` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.nodeLabels.*` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.osDiskSizeGB` |**None**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.osDiskType` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Allowed values:** `Managed`, `Ephemeral`<br/>|
| `global.nodePools.PATTERN.osType` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Allowed values:** `Linux`, `Windows`<br/>|
| `global.nodePools.PATTERN.replicas` |**None**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.scaleSetPriority` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Allowed values:** `Regular`, `Spot`<br/>|
| `global.nodePools.PATTERN.spotMaxPrice` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints` |**None**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints[*]` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints[*].effect` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Allowed values:** `NoSchedule`, `NoExecute`, `PreferNoSchedule`<br/>|
| `global.nodePools.PATTERN.taints[*].key` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints[*].value` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.vmSize` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|

### providerSpecific
Properties within the `.global.providerSpecific` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.providerSpecific.asoAuthentication` |**None**|**Type:** `object`<br/>|
| `global.providerSpecific.asoAuthentication.clientID` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.asoAuthentication.subscriptionID` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.asoAuthentication.tenantID` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.controlPlaneIdentity` |Identity assigned to the AKS control plane itself (separate from the CAPZ controller identity above).|**Type:** `object`<br/>|
| `global.providerSpecific.controlPlaneIdentity.type` |**None**|**Type:** `string`<br/>**Allowed values:** `SystemAssigned`, `UserAssigned`<br/>**Default:** `"SystemAssigned"`|
| `global.providerSpecific.controlPlaneIdentity.userAssignedIdentityResourceID` |**None**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.kubeletIdentityResourceID` |User-assigned identity used by the kubelet (typically for ACR pulls).|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.location` |Azure region (e.g. westeurope, eastus).|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.resourceGroupName` |Resource group that contains the AKS cluster. Defaults to the cluster name when empty. CAPZ creates the RG if it does not exist.|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.subscriptionId` |Azure subscription that hosts the AKS cluster.|**Type:** `string`<br/>**Default:** `""`|


<!-- DOCS_END -->
