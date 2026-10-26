# Values schema documentation

This page lists all available configuration options, based on the [configuration values schema](values.schema.json).

Note that configuration options can change between releases. Use the GitHub function for selecting a branch/tag to view the documentation matching your cluster-aks version.

<!-- Update the content below by executing (from the repo root directory)

make generate-docs

-->

<!-- DOCS_START -->

### Apps
Properties within the `.global.apps` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.apps.azureAksExtras` | **Azure AKS extras**|**Type:** `object`<br/>**Default:** `{}`|
| `global.apps.certManager` | **cert-manager extra configuration**|**Type:** `object`<br/>|
| `global.apps.certManager.extraConfigs` |**None**|**Type:** `array`<br/>**Default:** `[{"kind":"configMap","name":"{{ $.Values.global.metadata.name }}-cert-manager-identity"}]`|
| `global.apps.certManager.extraConfigs[*]` |**None**||
| `global.apps.certManager.extraConfigs[*].kind` |**None**|**Type:** `string`<br/>|
| `global.apps.certManager.extraConfigs[*].name` |**None**|**Type:** `string`<br/>|
| `global.apps.externalDns` | **external-dns extra configuration**|**Type:** `object`<br/>|
| `global.apps.externalDns.extraConfigs` |**None**|**Type:** `array`<br/>**Default:** `[{"kind":"configMap","name":"{{ $.Values.global.metadata.name }}-external-dns-identity"}]`|
| `global.apps.externalDns.extraConfigs[*]` |**None**||
| `global.apps.externalDns.extraConfigs[*].kind` |**None**|**Type:** `string`<br/>|
| `global.apps.externalDns.extraConfigs[*].name` |**None**|**Type:** `string`<br/>|

### Connectivity
Properties within the `.global.connectivity` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.connectivity.apiServerAccess` | **API server access** - Optional API server access controls (AKS public/private cluster).|**Type:** `object`<br/>|
| `global.connectivity.apiServerAccess.authorizedIPRanges` | **Authorized IP ranges**|**Type:** `array`<br/>**Default:** `[]`|
| `global.connectivity.apiServerAccess.authorizedIPRanges[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.apiServerAccess.enablePrivateCluster` | **Enable private cluster** - When true, the AKS API server is reachable only from inside the VNet (or via authorizedIPRanges).|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.apiServerAccess.enablePrivateClusterPublicFQDN` | **Enable private cluster public FQDN**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.apiServerAccess.privateDNSZone` | **Private DNS zone**|**Type:** `string`<br/>**Default:** `""`|
| `global.connectivity.baseDomain` | **Base domain** - DNS base domain used by the management cluster's installation.|**Type:** `string`<br/>**Default:** `""`|
| `global.connectivity.cni` | **CNI**|**Type:** `object`<br/>|
| `global.connectivity.cni.managed` | **Managed CNI** - BYO CNI opt-in, for new clusters only. When true, AKS installs no CNI (networkPlugin none) and Giant Swarm installs and operates Cilium. When false, the cluster uses AKS-managed networking. Unsupported until the BYO CNI mode is declared supported, see the README.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.dns` | **DNS**|**Type:** `object`<br/>|
| `global.connectivity.dns.wildcardCnameTarget` | **Wildcard CNAME Target** - Override the wildcard CNAME record value. If no value is passed defaults to "ingress". Only subdomains from the cluster DNS zone are valid.|**Type:** `string`<br/>**Example:** `"gateway"`<br/>|
| `global.connectivity.network` | **Network**|**Type:** `object`<br/>|
| `global.connectivity.network.dnsServiceIP` | **DNS service IP** - Must be within the service CIDR.|**Type:** `string`<br/>**Default:** `"172.20.0.10"`|
| `global.connectivity.network.pods` | **Pods network** - Pods CIDR. Used by AKS with kubenet and with Azure CNI Overlay (global.controlPlane.networking.networkPluginMode), and as the Cilium cluster pool on BYO CNI clusters (global.connectivity.cni.managed). Ignored with Azure CNI node-subnet. With overlay and BYO CNI it must have exactly one entry, which must not overlap the VNet, peered or on-premises networks, the service CIDR or the AKS reserved ranges 169.254.0.0/16, 172.30.0.0/16, 172.31.0.0/16, 192.0.2.0/24 and 224.0.0.0/4. Kept non-empty because the giantswarm/cluster subchart schema requires at least one entry.|**Type:** `object`<br/>|
| `global.connectivity.network.pods.cidrBlocks` | **CIDR blocks**|**Type:** `array`<br/>**Default:** `["192.168.0.0/16"]`|
| `global.connectivity.network.pods.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.services` | **Services network** - Services CIDR — assigned by AKS for Kubernetes Service IPs. Used to populate Cluster.spec.clusterNetwork.services. Must not overlap the VNet, peered or on-premises networks, the pod CIDR or the AKS reserved ranges 169.254.0.0/16, 172.30.0.0/16, 172.31.0.0/16, 192.0.2.0/24 and 224.0.0.0/4; AKS rejects the cluster otherwise.|**Type:** `object`<br/>|
| `global.connectivity.network.services.cidrBlocks` | **CIDR blocks**|**Type:** `array`<br/>**Default:** `["172.20.0.0/16"]`|
| `global.connectivity.network.services.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.vnet` | **VNet** - VNet for the cluster's node pools. By default the chart creates an Azure VirtualNetwork (via ASO) with one subnet inside it, and wires every node pool to that subnet. To bring your own VNet, set subnetArmId to the ARM ID of an existing subnet. When set, the chart does NOT create a VNet and every node pool references the provided subnet instead; cidrBlocks, name, and subnet.* are then ignored.|**Type:** `object`<br/>|
| `global.connectivity.network.vnet.cidrBlocks` | **CIDR blocks** - CIDR(s) of the chart-created VirtualNetwork's address space. Must not overlap the AKS reserved ranges 169.254.0.0/16, 172.30.0.0/16, 172.31.0.0/16, 192.0.2.0/24 and 224.0.0.0/4.|**Type:** `array`<br/>**Default:** `["10.224.0.0/12"]`|
| `global.connectivity.network.vnet.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.vnet.name` | **Name** - Name of the chart-created VirtualNetwork. Defaults to the cluster name when empty.|**Type:** `string`<br/>**Default:** `""`|
| `global.connectivity.network.vnet.subnet` | **Subnet**|**Type:** `object`<br/>|
| `global.connectivity.network.vnet.subnet.cidrBlocks` | **CIDR blocks** - CIDR of the chart-created subnet. Must lie within vnet.cidrBlocks.|**Type:** `array`<br/>**Default:** `["10.224.0.0/16"]`|
| `global.connectivity.network.vnet.subnet.cidrBlocks[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.network.vnet.subnet.name` | **Name** - Name of the chart-created subnet (Azure resource name).|**Type:** `string`<br/>**Default:** `"nodes"`|
| `global.connectivity.network.vnet.subnetArmId` | **Subnet ARM ID** - ARM ID of an existing subnet to use as the default for all node pools (bring-your-own VNet). When set, the chart skips VNet/Subnet creation, cidrBlocks/name/subnet.* above are ignored, and vnet.name must be left empty. Individual node pools can use a different subnet in the same VNet via global.nodePools.<pool>.subnetArmId. Format: /subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet>/subnets/<subnet>. Prerequisite: the ASO identity needs the Network Contributor role (or at least Microsoft.Network/virtualNetworks/subnets/join/action) on the subnet's resource group; for a subnet in another subscription, an additional role assignment is required there too.|**Type:** `string`<br/>**Value pattern:** `^$|^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\.Network/virtualNetworks/[^/]+/subnets/[^/]+$`<br/>**Default:** `""`|

### Control plane
Properties within the `.global.controlPlane` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.controlPlane.aadProfile` | **AAD profile** - AAD integration. When managed: true, AKS uses AAD for Kubernetes API authentication.|**Type:** `object`<br/>|
| `global.controlPlane.aadProfile.adminGroupObjectIDs` | **Admin group object IDs**|**Type:** `array`<br/>|
| `global.controlPlane.aadProfile.adminGroupObjectIDs[*]` |**None**|**Type:** `string`<br/>|
| `global.controlPlane.aadProfile.managed` | **Managed**|**Type:** `boolean`<br/>|
| `global.controlPlane.additionalTags` | **Additional tags** - Additional Azure tags applied to the underlying AKS resources.|**Type:** `object`<br/>**Default:** `{}`|
| `global.controlPlane.additionalTags.*` |**None**|**Type:** `string`<br/>|
| `global.controlPlane.disableLocalAccounts` | **Disable local accounts** - Disable AKS local accounts, so the static cluster-admin credential cannot be issued and all API server authentication goes through Entra ID. Requires aadProfile.managed: true. The ASO identity must also be granted cluster-admin in the workload cluster (Azure Kubernetes Service RBAC Cluster Admin Role when Azure RBAC is enabled, otherwise membership of one of aadProfile.adminGroupObjectIDs), because CAPZ reaches the cluster with an Entra token issued for that identity.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.controlPlane.dnsPrefix` | **DNS prefix** - DNS prefix. Defaults to the cluster name when empty.|**Type:** `string`<br/>**Default:** `""`|
| `global.controlPlane.logging` | **Logging** - Control plane logging. On AKS the API server runs on Microsoft's infrastructure, so its logs are only reachable through an Azure diagnostic setting.|**Type:** `object`<br/>|
| `global.controlPlane.logging.audit` | **Audit** - Ship Kubernetes API server audit logs off the AKS control plane into an Event Hub, from where a collector ingests them into Loki. On AKS the API server runs on Microsoft's infrastructure, so an Azure diagnostic setting is the only way to get these logs.|**Type:** `object`<br/>|
| `global.controlPlane.logging.audit.category` | **Category** - Azure diagnostic log category to collect. `kube-audit-admin` excludes get and list events and is considerably cheaper than `kube-audit`.|**Type:** `string`<br/>**Allowed values:** `kube-audit-admin`, `kube-audit`<br/>**Default:** `"kube-audit-admin"`|
| `global.controlPlane.logging.audit.enabled` | **Enabled** - Enable or disable API server audit logging (https://learn.microsoft.com/en-us/azure/aks/monitor-aks). Creates an Event Hub namespace, which is billed separately.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.controlPlane.logging.audit.eventHub` | **Event Hub** - Event Hub that the audit log stream is delivered to. The hub is a transport buffer, not the system of record: a collector drains it into Loki, which is where audit logs are queried and retained long term.|**Type:** `object`<br/>|
| `global.controlPlane.logging.audit.eventHub.namespaceName` | **Namespace name** - Name of the Event Hub namespace. Must be globally unique across Azure. Defaults to the cluster name suffixed with `-audit-` and a hash of the subscription and resource group.|**Type:** `string`<br/>**Default:** `""`|
| `global.controlPlane.logging.audit.eventHub.partitionCount` | **Partition count** - Number of partitions of the audit Event Hub.|**Type:** `integer`<br/>**Default:** `4`|
| `global.controlPlane.logging.audit.eventHub.retentionTimeInHours` | **Retention time in hours** - How long unread audit events are kept in the Event Hub before they are dropped. This only bounds how long a collector may be down without losing events, since Loki holds the long-term copy. 168 hours (7 days) is the maximum the Standard tier allows and is included in the price, so there is no reason to set it lower.|**Type:** `integer`<br/>**Default:** `168`|
| `global.controlPlane.networking` | **Networking** - AKS networking configuration.|**Type:** `object`<br/>|
| `global.controlPlane.networking.advancedNetworking` | **Advanced Container Networking Services** - ACNS, a paid Azure add-on billed to the cluster's subscription. Requires networkPlugin azure. Can be turned on or off on an existing cluster. Can't be combined with global.connectivity.cni.managed.|**Type:** `object`<br/>|
| `global.controlPlane.networking.advancedNetworking.enabled` | **Enabled** - Enable ACNS. When unset, the chart renders no advancedNetworking block and AKS keeps its current setting. Set to false to disable ACNS on a cluster that has it enabled. Required to be true for observability or security.|**Type:** `boolean`<br/>|
| `global.controlPlane.networking.advancedNetworking.observability` | **Observability**|**Type:** `object`<br/>|
| `global.controlPlane.networking.advancedNetworking.observability.enabled` | **Enabled** - Enable ACNS observability (Hubble network metrics and flow logs).|**Type:** `boolean`<br/>**Default:** `false`|
| `global.controlPlane.networking.advancedNetworking.security` | **Security**|**Type:** `object`<br/>|
| `global.controlPlane.networking.advancedNetworking.security.advancedNetworkPolicies` | **Advanced network policies** - Advanced network policies to enable. When unset, AKS applies FQDN. Requires security.enabled.|**Type:** `string`<br/>**Allowed values:** `FQDN`, `L7`, `None`<br/>|
| `global.controlPlane.networking.advancedNetworking.security.enabled` | **Enabled** - Enable ACNS security (FQDN filtering and L7 network policies). Requires networkDataplane cilium.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.controlPlane.networking.networkDataplane` | **Network dataplane** - Ignored when global.connectivity.cni.managed is true.|**Type:** `string`<br/>**Allowed values:** `azure`, `cilium`<br/>**Default:** `"cilium"`|
| `global.controlPlane.networking.networkMode` | **Network mode** - Ignored when global.connectivity.cni.managed is true.|**Type:** `string`<br/>**Allowed values:** `bridge`, `transparent`<br/>**Default:** `"transparent"`|
| `global.controlPlane.networking.networkPlugin` | **Network plugin** - Rendered as none when global.connectivity.cni.managed is true. Setting none without it fails.|**Type:** `string`<br/>**Allowed values:** `azure`, `kubenet`, `none`<br/>**Default:** `"azure"`|
| `global.controlPlane.networking.networkPluginMode` | **Network plugin mode** - Set to overlay for Azure CNI Overlay: pods get IPs from global.connectivity.network.pods.cidrBlocks (exactly one entry) instead of the VNet. Requires networkPlugin azure and networkMode transparent. Creation-time choice, existing clusters can't be migrated. The pod CIDR must not overlap the VNet, peered or on-premises networks, or the service CIDR. Pod egress is SNATed to the node IP and pod IPs aren't routable outside the cluster, so allowlists must use node or subnet IPs. Ignored when global.connectivity.cni.managed is true, which can't be combined with it.|**Type:** `string`<br/>**Allowed value:** `overlay`<br/>|
| `global.controlPlane.networking.networkPolicy` | **Network policy** - Ignored when global.connectivity.cni.managed is true.|**Type:** `string`<br/>**Allowed values:** `azure`, `calico`, `cilium`, `none`<br/>**Default:** `"cilium"`|
| `global.controlPlane.networking.outboundType` | **Outbound type** - How the cluster's egress leaves Azure. Creation-time choice, Azure rejects changing it on an existing cluster. userDefinedRouting requires a BYO subnet (global.connectivity.network.vnet.subnetArmId) whose route table sends 0.0.0.0/0 to your egress device, such as Azure Firewall or an NVA; with per-pool subnets (global.nodePools.<pool>.subnetArmId), each of them needs that route table too.|**Type:** `string`<br/>**Allowed values:** `loadBalancer`, `managedNATGateway`, `userAssignedNATGateway`, `userDefinedRouting`<br/>**Default:** `"loadBalancer"`|
| `global.controlPlane.sku` | **SKU** - AKS SKU tier.|**Type:** `object`<br/>|
| `global.controlPlane.sku.tier` | **Tier**|**Type:** `string`<br/>**Allowed values:** `Free`, `Premium`, `Standard`<br/>**Default:** `"Standard"`|

### Metadata
Properties within the `.global.metadata` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.metadata.annotations` | **Annotations**|**Type:** `object`<br/>**Default:** `{}`|
| `global.metadata.annotations.*` |**None**|**Type:** `string`<br/>|
| `global.metadata.description` | **Description**|**Type:** `string`<br/>**Default:** `""`|
| `global.metadata.labels` | **Labels**|**Type:** `object`<br/>**Default:** `{}`|
| `global.metadata.labels.*` |**None**|**Type:** `string`<br/>|
| `global.metadata.name` | **Name** - Name of the workload cluster. Defaults to the Helm release name when unset. Must comply with Azure resource naming rules.|**Type:** `string`<br/>**Default:** `""`|
| `global.metadata.organization` | **Organization**|**Type:** `string`<br/>**Default:** `""`|
| `global.metadata.preventDeletion` | **Prevent deletion**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.metadata.servicePriority` | **Service priority**|**Type:** `string`<br/>**Allowed values:** `lowest`, `medium`, `highest`<br/>**Default:** `"highest"`|

### Node pools
Properties within the `.global.nodePools` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.nodePools.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.additionalTags` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.additionalTags.*` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.availabilityZones` |**None**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.availabilityZones[*]` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.enableAutoScaling` |**None**|**Type:** `boolean`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Default:** `true`|
| `global.nodePools.PATTERN.maxPods` |**None**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Default:** `110`|
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
| `global.nodePools.PATTERN.subnetArmId` | **Subnet ARM ID** - ARM ID of an existing subnet for this node pool, overriding global.connectivity.network.vnet.subnetArmId. Only allowed in bring-your-own VNet mode (global.connectivity.network.vnet.subnetArmId set), and the subnet must be in the same VNet. Falls back to global.connectivity.network.vnet.subnetArmId when unset. The ASO identity needs Microsoft.Network/virtualNetworks/subnets/join/action on this subnet too. With networkPlugin kubenet, the AKS route table must be associated with this subnet as well.|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Value pattern:** `^$|^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\.Network/virtualNetworks/[^/]+/subnets/[^/]+$`<br/>|
| `global.nodePools.PATTERN.taints` |**None**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints[*]` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints[*].effect` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>**Allowed values:** `NoSchedule`, `NoExecute`, `PreferNoSchedule`<br/>|
| `global.nodePools.PATTERN.taints[*].key` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.taints[*].value` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|
| `global.nodePools.PATTERN.vmSize` |**None**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{1,12}$`<br/>|

### Other global

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.managementCluster` | **Management cluster**|**Type:** `string`<br/>**Default:** `""`|

### Provider-specific configuration
Properties within the `.global.providerSpecific` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.providerSpecific.asoAuthenticationSecretName` | **ASO authentication secret name** - Name of the secret containing the ASO credentials. If empty, the chart creates a secret with the ASO credentials derived from the AzureClusterIdentity resource.|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.azureClusterIdentity` | **Identity** - AzureClusterIdentity resource to use for this cluster.|**Type:** `object`<br/>|
| `global.providerSpecific.azureClusterIdentity.name` | **Name**|**Type:** `string`<br/>**Default:** `"cluster-identity"`|
| `global.providerSpecific.azureClusterIdentity.namespace` | **Namespace**|**Type:** `string`<br/>**Default:** `"org-giantswarm"`|
| `global.providerSpecific.controlPlaneIdentity` | **Control plane identity** - Identity assigned to the AKS control plane itself (separate from the CAPZ controller identity above).|**Type:** `object`<br/>|
| `global.providerSpecific.controlPlaneIdentity.type` | **Type**|**Type:** `string`<br/>**Allowed values:** `SystemAssigned`, `UserAssigned`<br/>**Default:** `"SystemAssigned"`|
| `global.providerSpecific.controlPlaneIdentity.userAssignedIdentityResourceID` | **User-assigned identity resource ID**|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.kubeletIdentityResourceID` | **Kubelet identity resource ID** - User-assigned identity used by the kubelet (typically for ACR pulls).|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.location` | **Location** - Azure region (e.g. westeurope, eastus).|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.nodeOSUpgrade` | **Node OS upgrade** - Automatic OS patching for all node pools. Never changes the Kubernetes version, which follows the Giant Swarm release.|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.channel` | **Channel** - NodeImage: weekly reimage to a new node image. SecurityPatch: AKS-tested security patches, live where possible. Unmanaged: OS-native patching. None: no OS updates.|**Type:** `string`<br/>**Allowed values:** `NodeImage`, `SecurityPatch`, `Unmanaged`, `None`<br/>**Default:** `"NodeImage"`|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow` | **Maintenance window** - Window in which AKS may start node OS upgrades. If unset, upgrades can start at any time.|**Type:** `object`<br/>**Default:** `{}`|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.durationHours` | **Duration hours** - Length of the maintenance window in hours, between 4 and 24.|**Type:** `integer`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.notAllowedDates` | **Not allowed dates** - Date ranges in which no maintenance may start, even if they overlap with the window.|**Type:** `array`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.notAllowedDates[*]` |**None**|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.notAllowedDates[*].end` | **End** - Last day of the blocked date range, in YYYY-MM-DD format.|**Type:** `string`<br/>**Value pattern:** `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.notAllowedDates[*].start` | **Start** - First day of the blocked date range, in YYYY-MM-DD format.|**Type:** `string`<br/>**Value pattern:** `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule` | **Schedule** - Recurrence of the maintenance window. Set exactly one of daily, weekly, absoluteMonthly or relativeMonthly.|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.absoluteMonthly` | **Absolute monthly** - Run on a fixed day of the month, e.g. every month on the 1st.|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.absoluteMonthly.dayOfMonth` | **Day of month** - Day of the month on which the maintenance window opens, between 1 and 31.|**Type:** `integer`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.absoluteMonthly.intervalMonths` | **Interval months** - Number of months between maintenance windows, between 1 and 6.|**Type:** `integer`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.daily` | **Daily** - Open the maintenance window every N days (only supported for node OS upgrades).|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.daily.intervalDays` | **Interval days** - Number of days between maintenance windows, between 1 and 7.|**Type:** `integer`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.relativeMonthly` | **Relative monthly** - Run on a weekday of a given week of the month, e.g. every month on the last Sunday.|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.relativeMonthly.dayOfWeek` | **Day of week** - Weekday on which the maintenance window opens, from Monday to Sunday.|**Type:** `string`<br/>**Allowed values:** `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, `Sunday`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.relativeMonthly.intervalMonths` | **Interval months** - Number of months between maintenance windows, between 1 and 6.|**Type:** `integer`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.relativeMonthly.weekIndex` | **Week index** - Week of the month in which the window opens: First, Second, Third, Fourth or Last.|**Type:** `string`<br/>**Allowed values:** `First`, `Second`, `Third`, `Fourth`, `Last`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.weekly` | **Weekly** - Open the maintenance window on a given weekday, every N weeks.|**Type:** `object`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.weekly.dayOfWeek` | **Day of week** - Weekday on which the maintenance window opens, from Monday to Sunday.|**Type:** `string`<br/>**Allowed values:** `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, `Sunday`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.schedule.weekly.intervalWeeks` | **Interval weeks** - Number of weeks between maintenance windows, between 1 and 4.|**Type:** `integer`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.startDate` | **Start date** - Date from which the window takes effect (YYYY-MM-DD). Defaults to the creation date.|**Type:** `string`<br/>**Example:** `"2026-10-05"`<br/>**Value pattern:** `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.startTime` | **Start** - Time of day the window opens (HH:MM), in the time zone given by utcOffset.|**Type:** `string`<br/>**Example:** `"02:00"`<br/>**Value pattern:** `^[0-2][0-9]:[0-5][0-9]$`<br/>|
| `global.providerSpecific.nodeOSUpgrade.maintenanceWindow.utcOffset` | **UTC offset** - Time zone of startTime, e.g. +02:00. Defaults to +00:00.|**Type:** `string`<br/>**Example:** `"+02:00"`<br/>**Value pattern:** `^[-+][0-9]{2}:[0-9]{2}$`<br/>|
| `global.providerSpecific.resourceGroupName` | **Resource group name** - Resource group that contains the AKS cluster. Defaults to the cluster name when empty. CAPZ creates the RG if it does not exist.|**Type:** `string`<br/>**Default:** `""`|
| `global.providerSpecific.subscriptionId` | **Subscription ID** - Azure subscription that hosts the AKS cluster.|**Type:** `string`<br/>**Default:** `""`|

### cluster
Properties within the `.cluster` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `cluster.providerIntegration` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certExporter` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certExporter.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSCertExporterHelmValues"`|
| `cluster.providerIntegration.apps.certExporter.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.certManager` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certManager.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSCertManagerHelmValues"`|
| `cluster.providerIntegration.apps.certManager.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.certManagerCrossplaneResources` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.certManagerCrossplaneResources.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSCertManagerCrossplaneResourcesHelmValues"`|
| `cluster.providerIntegration.apps.certManagerCrossplaneResources.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.chartOperatorExtensions` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.chartOperatorExtensions.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.cilium` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.cilium.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSCiliumHelmValues"`|
| `cluster.providerIntegration.apps.cilium.enable` |Only rendered when global.connectivity.cni.managed is true.|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.ciliumServiceMonitors` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.ciliumServiceMonitors.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.clusterAutoscaler` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.clusterAutoscaler.enable` |**None**|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.coreDns` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.coreDns.enable` |Already managed by AKS.|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.coreDnsExtensions` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.coreDnsExtensions.enable` |Already managed by AKS.|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.externalDns` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.externalDns.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSExternalDnsHelmValues"`|
| `cluster.providerIntegration.apps.externalDns.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.externalDnsCrossplaneResources` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.externalDnsCrossplaneResources.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSExternalDnsCrossplaneResources"`|
| `cluster.providerIntegration.apps.externalDnsCrossplaneResources.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.k8sDnsNodeCache` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.k8sDnsNodeCache.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSK8sDnsNodeCacheHelmValues"`|
| `cluster.providerIntegration.apps.k8sDnsNodeCache.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.metricsServer` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.metricsServer.enable` |Already managed by AKS.|**Type:** `boolean`<br/>**Default:** `false`|
| `cluster.providerIntegration.apps.netExporter` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.netExporter.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.networkPolicies` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.networkPolicies.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSNetworkPoliciesHelmValues"`|
| `cluster.providerIntegration.apps.networkPolicies.enable` |**None**|**Type:** `boolean`<br/>**Default:** `true`|
| `cluster.providerIntegration.apps.nodeExporter` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.apps.nodeExporter.configTemplateName` |**None**|**Type:** `string`<br/>**Default:** `"AKSNodeExporterHelmValues"`|
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
| `cluster.providerIntegration.workers.defaultNodePools.system.maxSize` |**None**|**Type:** `integer`<br/>**Default:** `3`|
| `cluster.providerIntegration.workers.defaultNodePools.system.minSize` |**None**|**Type:** `integer`<br/>**Default:** `1`|
| `cluster.providerIntegration.workers.defaultNodePools.system.mode` |**None**|**Type:** `string`<br/>**Default:** `"System"`|
| `cluster.providerIntegration.workers.defaultNodePools.system.osDiskSizeGB` |**None**|**Type:** `integer`<br/>**Default:** `128`|
| `cluster.providerIntegration.workers.defaultNodePools.system.osDiskType` |**None**|**Type:** `string`<br/>**Default:** `"Managed"`|
| `cluster.providerIntegration.workers.defaultNodePools.system.osType` |**None**|**Type:** `string`<br/>**Default:** `"Linux"`|
| `cluster.providerIntegration.workers.defaultNodePools.system.vmSize` |**None**|**Type:** `string`<br/>**Default:** `"Standard_D2as_v5"`|
| `cluster.providerIntegration.workers.kubeadmConfig` |**None**|**Type:** `object`<br/>|
| `cluster.providerIntegration.workers.kubeadmConfig.enabled` |**None**|**Type:** `boolean`<br/>**Default:** `false`|

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

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `managementCluster` | **Management cluster** - Name of the Cluster API cluster managing this workload cluster.|**Type:** `string`<br/>|
| `provider` | **Cluster API provider name**|**Type:** `string`<br/>|


<!-- DOCS_END -->
