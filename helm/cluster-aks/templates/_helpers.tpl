{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
The workload cluster name. Mirrors the helper defined by the cluster subchart
(cluster.resource.name) so that this chart's CRs end up with the exact same
name the subchart uses for the Cluster CR, satisfying CAPI's ref-by-name
contract.
*/}}
{{- define "cluster-aks.resource.name" -}}
{{- .Values.global.metadata.name | default (.Release.Name | replace "." "-" | trunc 47 | trimSuffix "-") -}}
{{- end -}}

{{/*
Name of the Azure resource group that holds the AKS cluster and its
related Azure resources. Defaults to the cluster name when
global.providerSpecific.resourceGroupName is unset.
*/}}
{{- define "cluster-aks.resourceGroup.name" -}}
{{- .Values.global.providerSpecific.resourceGroupName | default (include "cluster-aks.resource.name" .) -}}
{{- end -}}

{{/*
Name of the Kubernetes Secret that holds the Azure credentials used by the
Azure Service Operator (ASO) to reconcile the embedded Azure resources.
Empty when no asoAuthentication.clientID is configured, so the credential-from
annotation in the ASO resources is omitted and ASO falls back to its default
credential resolution.
*/}}
{{- define "cluster-aks.aso.credentialSecretName" -}}
{{- if .Values.global.providerSpecific.asoAuthentication.clientID -}}
{{- printf "%s-aso-credentials" (include "cluster-aks.resource.name" .) -}}
{{- end -}}
{{- end -}}

{{/*
Whether the cluster uses a bring-your-own VNet. True when
global.connectivity.network.vnet.subnetArmId is set, in which case the
chart does not create a VNet and every node pool references the given
subnet by ARM ID.
*/}}
{{- define "cluster-aks.vnet.byo" -}}
{{- if .Values.global.connectivity.network.vnet.subnetArmId -}}true{{- end -}}
{{- end -}}

{{/*
Azure name of the chart-created VirtualNetwork. Defaults to the cluster name
when global.connectivity.network.vnet.name is unset.
*/}}
{{- define "cluster-aks.vnet.name" -}}
{{- .Values.global.connectivity.network.vnet.name | default (include "cluster-aks.resource.name" .) -}}
{{- end -}}

{{/*
Azure name of the chart-created subnet inside the VirtualNetwork. Defaults
to "nodes" when global.connectivity.network.vnet.subnet.name is unset.
*/}}
{{- define "cluster-aks.subnet.name" -}}
{{- .Values.global.connectivity.network.vnet.subnet.name | default "nodes" -}}
{{- end -}}

{{/*
Kubernetes object name of the chart-created VirtualNetworksSubnet CR. The
ASO CR name combines the VNet name and the subnet name to keep it unique
inside the namespace when multiple clusters share it.
*/}}
{{- define "cluster-aks.subnet.crName" -}}
{{- printf "%s-%s" (include "cluster-aks.vnet.name" .) (include "cluster-aks.subnet.name" .) -}}
{{- end -}}

{{/*
Name of the AzureClusterIdentity CR that mirrors the ASO credentials secret.
*/}}
{{- define "cluster-aks.azureClusterIdentity.name" -}}
{{- printf "%s-identity" (include "cluster-aks.resource.name" .) -}}
{{- end -}}

{{/*
Common labels applied to every resource rendered by this chart.
*/}}
{{- define "labels.common" -}}
app: {{ include "name" . | quote }}
{{ include "labels.selector" . }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
giantswarm.io/cluster: {{ include "cluster-aks.resource.name" . | quote }}
{{- with .Values.global.metadata.organization }}
giantswarm.io/organization: {{ . | quote }}
{{- end }}
cluster.x-k8s.io/cluster-name: {{ include "cluster-aks.resource.name" . | quote }}
cluster.x-k8s.io/watch-filter: capi
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app.kubernetes.io/name: {{ include "name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Annotations placed on the Cluster CR by the cluster subchart. The subchart
includes whichever named template is configured under
providerIntegration.clusterAnnotationsTemplateName.
*/}}
{{- define "azureClusterAnnotations" -}}
{{- with .Values.global.providerSpecific.location }}
giantswarm.io/azure-location: {{ . | quote }}
{{- end }}
{{- with .Values.global.providerSpecific.subscriptionId }}
giantswarm.io/azure-subscription-id: {{ . | quote }}
{{- end }}
{{- end -}}

{{/*
Empty named template used to satisfy the cluster subchart's schema
requirement for an infrastructureMachineTemplateSpecTemplateName when the
control plane provider is "external" (AKS-managed control plane).
*/}}
{{- define "noop" -}}
{}
{{- end -}}

{{/*
Bootstrap block embedded into the CAPI MachinePool template by the cluster
subchart. AKS pools have no bootstrap dataSecret because kubelet
provisioning is handled by AKS itself.

A leading blank line is intentional: the subchart includes this template
with `| indent 8` right after `bootstrap:`, and without it the content
would collapse onto the same line.
*/}}
{{- define "azureMachinePoolBootstrap" }}
dataSecretName: ""
{{- end }}
