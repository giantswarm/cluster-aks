{{- define "azure-aso-managed-control-plane" -}}
{{- $cp := .Values.global.controlPlane -}}
{{- $ps := .Values.global.providerSpecific -}}
{{- $net := .Values.global.connectivity -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureASOManagedControlPlane
metadata:
  name: {{ $clusterName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
    {{- if (include "cluster-aks.aso.credentialSecretName" .) }}
    "azure.giantswarm.io/azure-cluster-identity": {{ include "cluster-aks.azureClusterIdentity.name" . }}
    {{- end }}
spec:
  version: {{ include "cluster.component.kubernetes.version" . }}
  resources:
    - apiVersion: containerservice.azure.com/v1api20240901
      kind: ManagedCluster
      metadata:
        name: {{ $clusterName }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ $clusterName }}
        location: {{ required "global.providerSpecific.location is required" $ps.location | quote }}
        dnsPrefix: {{ $cp.dnsPrefix | default $clusterName | quote }}
        identity:
          type: {{ $ps.controlPlaneIdentity.type }}
          {{- if and (eq $ps.controlPlaneIdentity.type "UserAssigned") $ps.controlPlaneIdentity.userAssignedIdentityResourceID }}
          userAssignedIdentities:
            - reference:
                armId: {{ $ps.controlPlaneIdentity.userAssignedIdentityResourceID | quote }}
          {{- end }}
        servicePrincipalProfile:
          clientId: msi
        sku:
          name: Base
          tier: {{ $cp.sku.tier }}
        networkProfile:
          dnsServiceIP: {{ $net.network.dnsServiceIP | quote }}
          networkPlugin: {{ $cp.networking.networkPlugin }}
          {{- with $cp.networking.networkDataplane }}
          networkDataplane: {{ . }}
          {{- end }}
          {{- with $cp.networking.networkMode }}
          networkMode: {{ . }}
          {{- end }}
          {{- with $cp.networking.networkPolicy }}
          networkPolicy: {{ . }}
          {{- end }}
          outboundType: {{ $cp.networking.outboundType }}
          {{- with (first ($net.network.services.cidrBlocks | default list)) }}
          serviceCidr: {{ . | quote }}
          {{- end }}
          {{- if eq $cp.networking.networkPlugin "kubenet" }}
          {{- with (first ($net.network.pods.cidrBlocks | default list)) }}
          podCidr: {{ . | quote }}
          {{- end }}
          {{- end }}
        oidcIssuerProfile:
          enabled: true
        {{- if hasKey $cp.aadProfile "managed" }}
        aadProfile:
          managed: {{ $cp.aadProfile.managed }}
          adminGroupObjectIDs:
            {{- toYaml ($cp.aadProfile.adminGroupObjectIDs | default list) | nindent 12 }}
        {{- end }}
        {{- if or $net.apiServerAccess.enablePrivateCluster $net.apiServerAccess.authorizedIPRanges }}
        apiServerAccessProfile:
          enablePrivateCluster: {{ $net.apiServerAccess.enablePrivateCluster }}
          {{- if $net.apiServerAccess.enablePrivateCluster }}
          enablePrivateClusterPublicFQDN: {{ $net.apiServerAccess.enablePrivateClusterPublicFQDN }}
          {{- with $net.apiServerAccess.privateDNSZone }}
          privateDNSZone: {{ . | quote }}
          {{- end }}
          {{- end }}
          {{- with $net.apiServerAccess.authorizedIPRanges }}
          authorizedIPRanges:
            {{- toYaml . | nindent 12 }}
          {{- end }}
        {{- end }}
        {{- if ne $cp.autoUpgradeChannel "none" }}
        autoUpgradeProfile:
          upgradeChannel: {{ $cp.autoUpgradeChannel }}
        {{- end }}
        {{- with $ps.kubeletIdentityResourceID }}
        identityProfile:
          kubeletidentity:
            resourceReference:
              armId: {{ . | quote }}
        {{- end }}
        {{- with $cp.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
{{- end -}}
