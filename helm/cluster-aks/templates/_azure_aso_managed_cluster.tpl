{{- define "azure-aso-managed-cluster" -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
{{- $vnet := .Values.global.connectivity.network.vnet -}}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureASOManagedCluster
metadata:
  name: {{ $clusterName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
    # These two annotations reference the AzureClusterIdentity resource that is used to derive the ASO credentials that are used to create the Azure resources for this cluster.
    # They are used by our operators to access the Azure subscription and create the resources for this cluster.
    "azure.giantswarm.io/azure-cluster-identity": {{ .Values.global.providerSpecific.azureClusterIdentity.name }}
    "azure.giantswarm.io/azure-cluster-identity-namespace": {{ .Values.global.providerSpecific.azureClusterIdentity.namespace }}
    {{- if .Values.global.connectivity.dns.wildcardCnameTarget }}
    {{- if regexMatch "\\." .Values.global.connectivity.dns.wildcardCnameTarget }}
    {{- fail "global.connectivity.dns.wildcardCnameTarget must be a single word - no FQDNs are allowed" }}
    {{- end }}
    network.giantswarm.io/wildcard-cname-target: "{{ .Values.global.connectivity.dns.wildcardCnameTarget }}"
    {{- end }}
spec:
  resources:
    - apiVersion: resources.azure.com/v1api20200601
      kind: ResourceGroup
      metadata:
        name: {{ $clusterName }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        azureName: {{ include "cluster-aks.resourceGroup.name" . | quote }}
        location: {{ required "global.providerSpecific.location is required" .Values.global.providerSpecific.location | quote }}
        {{- with .Values.global.controlPlane.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
    {{- if not (include "cluster-aks.vnet.byo" .) }}
    - apiVersion: network.azure.com/v1api20240301
      kind: VirtualNetwork
      metadata:
        name: {{ include "cluster-aks.vnet.name" . }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ $clusterName }}
        azureName: {{ include "cluster-aks.vnet.name" . | quote }}
        location: {{ .Values.global.providerSpecific.location | quote }}
        addressSpace:
          addressPrefixes:
            {{- toYaml $vnet.cidrBlocks | nindent 12 }}
        {{- with .Values.global.controlPlane.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
    - apiVersion: network.azure.com/v1api20240301
      kind: VirtualNetworksSubnet
      metadata:
        name: {{ include "cluster-aks.subnet.crName" . }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ include "cluster-aks.vnet.name" . }}
        azureName: {{ include "cluster-aks.subnet.name" . | quote }}
        addressPrefix: {{ first $vnet.subnet.cidrBlocks | quote }}
    {{- end }}
    {{- if include "cluster-aks.audit.enabled" . }}
    {{- $audit := .Values.global.controlPlane.logging.audit }}
    - apiVersion: eventhub.azure.com/v1api20240101
      kind: Namespace
      metadata:
        name: {{ include "cluster-aks.audit.crName" . }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ $clusterName }}
        azureName: {{ include "cluster-aks.audit.eventHubNamespace.name" . | quote }}
        location: {{ .Values.global.providerSpecific.location | quote }}
        sku:
          name: Standard
          tier: Standard
          capacity: 1
        {{- with .Values.global.controlPlane.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
    - apiVersion: eventhub.azure.com/v1api20240101
      kind: NamespacesEventhub
      metadata:
        name: {{ include "cluster-aks.audit.crName" . }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ include "cluster-aks.audit.crName" . }}
        azureName: {{ include "cluster-aks.audit.eventHub.name" . | quote }}
        partitionCount: {{ $audit.eventHub.partitionCount }}
        retentionDescription:
          cleanupPolicy: Delete
          retentionTimeInHours: {{ $audit.eventHub.retentionTimeInHours }}
    - apiVersion: eventhub.azure.com/v1api20240101
      kind: NamespacesAuthorizationRule
      metadata:
        name: {{ include "cluster-aks.audit.crName" . }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ include "cluster-aks.audit.crName" . }}
        azureName: audit
        # Manage and Send are required by the diagnostic setting that writes the
        # stream, Listen by the collector that reads it.
        rights:
          - Listen
          - Manage
          - Send
        operatorSpec:
          secrets:
            primaryConnectionString:
              name: {{ include "cluster-aks.audit.connectionStringSecretName" . }}
              key: primaryConnectionString
    - apiVersion: insights.azure.com/v1api20210501preview
      kind: DiagnosticSetting
      metadata:
        name: {{ include "cluster-aks.audit.crName" . }}
        {{- with (include "cluster-aks.aso.credentialSecretName" .) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        # The diagnostic setting is an extension resource on the AKS cluster
        # itself, which the AzureASOManagedControlPlane creates.
        owner:
          group: containerservice.azure.com
          kind: ManagedCluster
          name: {{ $clusterName }}
        azureName: audit
        eventHubAuthorizationRuleReference:
          group: eventhub.azure.com
          kind: NamespacesAuthorizationRule
          name: {{ include "cluster-aks.audit.crName" . }}
        eventHubName: {{ include "cluster-aks.audit.eventHub.name" . | quote }}
        logs:
          - category: {{ $audit.category | quote }}
            enabled: true
    {{- end }}
{{- end -}}
