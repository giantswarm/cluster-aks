{{- define "azure-managed-control-plane" -}}
{{- $cp := .Values.global.controlPlane -}}
{{- $ps := .Values.global.providerSpecific -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureManagedControlPlane
metadata:
  name: {{ $clusterName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
spec:
  location: {{ required "global.providerSpecific.location is required" $ps.location | quote }}
  subscriptionID: {{ required "global.providerSpecific.subscriptionId is required" $ps.subscriptionId | quote }}
  resourceGroupName: {{ $ps.resourceGroupName | default $clusterName | quote }}
  version: {{ include "cluster.component.kubernetes.version" . }}
  dnsPrefix: {{ $cp.dnsPrefix | default $clusterName | quote }}
  identityRef:
    apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
    kind: AzureClusterIdentity
    name: {{ include "cluster-aks.identity.name" . | quote }}
    namespace: {{ include "cluster-aks.identity.namespace" . | quote }}
  identity:
    type: {{ $ps.controlPlaneIdentity.type }}
    {{- if and (eq $ps.controlPlaneIdentity.type "UserAssigned") $ps.controlPlaneIdentity.userAssignedIdentityResourceID }}
    userAssignedIdentityResourceID: {{ $ps.controlPlaneIdentity.userAssignedIdentityResourceID | quote }}
    {{- end }}
  {{- with $ps.kubeletIdentityResourceID }}
  kubeletUserAssignedIdentity: {{ . | quote }}
  {{- end }}
  sku:
    tier: {{ $cp.sku.tier }}
  outboundType: {{ $cp.outboundType }}
  networkPlugin: {{ $cp.networking.networkPlugin }}
  {{- with $cp.networking.networkPluginMode }}
  networkPluginMode: {{ . }}
  {{- end }}
  {{- with $cp.networking.networkPolicy }}
  networkPolicy: {{ . }}
  {{- end }}
  oidcIssuerProfile:
    enabled: {{ $cp.oidcIssuer.enabled }}
  {{- if hasKey $cp.aadProfile "managed" }}
  aadProfile:
    managed: {{ $cp.aadProfile.managed }}
    adminGroupObjectIDs:
      {{- toYaml ($cp.aadProfile.adminGroupObjectIDs | default list) | nindent 6 }}
  {{- end }}
  {{- if or .Values.global.connectivity.apiServerAccess.enablePrivateCluster .Values.global.connectivity.apiServerAccess.authorizedIPRanges }}
  apiServerAccessProfile:
    enablePrivateCluster: {{ .Values.global.connectivity.apiServerAccess.enablePrivateCluster }}
    {{- if .Values.global.connectivity.apiServerAccess.enablePrivateCluster }}
    enablePrivateClusterPublicFQDN: {{ .Values.global.connectivity.apiServerAccess.enablePrivateClusterPublicFQDN }}
    {{- with .Values.global.connectivity.apiServerAccess.privateDNSZone }}
    privateDNSZone: {{ . | quote }}
    {{- end }}
    {{- end }}
    {{- with .Values.global.connectivity.apiServerAccess.authorizedIPRanges }}
    authorizedIPRanges:
      {{- toYaml . | nindent 6 }}
    {{- end }}
  {{- end }}
  {{- if ne $cp.autoUpgradeChannel "none" }}
  autoUpgradeProfile:
    upgradeChannel: {{ $cp.autoUpgradeChannel }}
  {{- end }}
  {{- with $cp.additionalTags }}
  additionalTags:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
