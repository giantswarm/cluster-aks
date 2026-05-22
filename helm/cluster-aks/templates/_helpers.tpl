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
Name of the AzureClusterIdentity. Falls back to the cluster name when the
user has not provided an explicit identity name.
*/}}
{{- define "cluster-aks.identity.name" -}}
{{- .Values.global.providerSpecific.azureClusterIdentity.name | default (include "cluster-aks.resource.name" .) -}}
{{- end -}}

{{/*
Namespace of the AzureClusterIdentity. Falls back to the release namespace.
*/}}
{{- define "cluster-aks.identity.namespace" -}}
{{- .Values.global.providerSpecific.azureClusterIdentity.namespace | default .Release.Namespace -}}
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
