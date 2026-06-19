{{- define "azure-cluster-identity" -}}
{{- $auth := .Values.global.providerSpecific.asoAuthentication -}}
{{- if $auth.clientID -}}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureClusterIdentity
metadata:
  name: {{ include "cluster-aks.azureClusterIdentity.name" . }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
spec:
  type: WorkloadIdentity
  clientID: {{ $auth.clientID | quote }}
  tenantID: {{ $auth.tenantID | quote }}
  allowedNamespaces:
    list:
      - {{ .Release.Namespace }}
{{- end -}}
{{- end -}}
