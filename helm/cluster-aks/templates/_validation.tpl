{{/*
Cross-field validation. Produces no output — only `fail` calls as side effects.
*/}}
{{- define "validation" -}}
{{- $nodePools := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools -}}
{{- if not $nodePools -}}
{{- fail "global.nodePools must define at least one node pool" -}}
{{- end -}}
{{- $systemPools := list -}}
{{- range $name, $pool := $nodePools -}}
  {{- if eq (default "User" $pool.mode) "System" -}}
    {{- $systemPools = append $systemPools $name -}}
  {{- end -}}
{{- end -}}
{{- if eq (len $systemPools) 0 -}}
{{- fail "at least one node pool in global.nodePools must have mode: System (AKS requires a system pool)" -}}
{{- end -}}
{{- $vnet := .Values.global.connectivity.network.vnet -}}
{{- if not $vnet.subnetArmId -}}
  {{- if not $vnet.cidrBlocks -}}
{{- fail "global.connectivity.network.vnet.cidrBlocks must be non-empty unless global.connectivity.network.vnet.subnetArmId is set (BYO VNet)" -}}
  {{- end -}}
  {{- if not $vnet.subnet.cidrBlocks -}}
{{- fail "global.connectivity.network.vnet.subnet.cidrBlocks must be non-empty unless global.connectivity.network.vnet.subnetArmId is set (BYO VNet)" -}}
  {{- end -}}
{{- else if $vnet.name -}}
{{- fail "global.connectivity.network.vnet.name is ignored when global.connectivity.network.vnet.subnetArmId is set (BYO VNet); remove one of the two to avoid ambiguous configuration" -}}
{{- end -}}
{{- $vnetArmId := regexReplaceAll "/subnets/[^/]+$" (lower $vnet.subnetArmId) "" -}}
{{- range $name, $pool := $nodePools -}}
  {{- if $pool.subnetArmId -}}
    {{- if not $vnet.subnetArmId -}}
{{- fail (printf "global.nodePools.%s.subnetArmId requires global.connectivity.network.vnet.subnetArmId to be set; per-pool subnets are only supported with a bring-your-own VNet" $name) -}}
    {{- end -}}
    {{- if ne (regexReplaceAll "/subnets/[^/]+$" (lower $pool.subnetArmId) "") $vnetArmId -}}
{{- fail (printf "global.nodePools.%s.subnetArmId must be a subnet in the same VNet as global.connectivity.network.vnet.subnetArmId; AKS requires all node pools to share one VNet" $name) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- $cp := .Values.global.controlPlane -}}
{{- if and (eq $cp.networking.networkPlugin "none") (not .Values.global.connectivity.cni.managed) -}}
{{- fail "global.controlPlane.networking.networkPlugin none requires global.connectivity.cni.managed: true; without it the cluster would have no CNI" -}}
{{- end -}}
{{- $networking := $cp.networking -}}
{{- $acns := $networking.advancedNetworking -}}
{{- $acnsOn := or $acns.observability.enabled $acns.security.enabled -}}
{{- if $networking.networkPluginMode -}}
  {{- if ne $networking.networkPlugin "azure" -}}
{{- fail "global.controlPlane.networking.networkPluginMode overlay requires global.controlPlane.networking.networkPlugin azure" -}}
  {{- end -}}
  {{- if eq $networking.networkMode "bridge" -}}
{{- fail "global.controlPlane.networking.networkPluginMode overlay doesn't support global.controlPlane.networking.networkMode bridge; use transparent" -}}
  {{- end -}}
{{- end -}}
{{- if and $acnsOn (ne $networking.networkPlugin "azure") -}}
{{- fail "global.controlPlane.networking.advancedNetworking requires global.controlPlane.networking.networkPlugin azure" -}}
{{- end -}}
{{- if and $acns.security.enabled (ne $networking.networkDataplane "cilium") -}}
{{- fail "global.controlPlane.networking.advancedNetworking.security.enabled requires global.controlPlane.networking.networkDataplane cilium" -}}
{{- end -}}
{{- if and $acns.security.advancedNetworkPolicies (not $acns.security.enabled) -}}
{{- fail "global.controlPlane.networking.advancedNetworking.security.advancedNetworkPolicies requires global.controlPlane.networking.advancedNetworking.security.enabled: true" -}}
{{- end -}}
{{- if and .Values.global.connectivity.cni.managed (or $networking.networkPluginMode $acnsOn) -}}
{{- fail "global.controlPlane.networking.networkPluginMode and global.controlPlane.networking.advancedNetworking are AKS-managed networking features and can't be used with the BYO CNI opt-in global.connectivity.cni.managed: true" -}}
{{- end -}}
{{- if and $cp.disableLocalAccounts (not $cp.aadProfile.managed) -}}
{{- fail "global.controlPlane.disableLocalAccounts requires global.controlPlane.aadProfile.managed: true; AKS only accepts disabling local accounts on Entra-integrated clusters, and without it no client (including CAPZ) can authenticate to the API server" -}}
{{- end -}}
{{- end -}}
