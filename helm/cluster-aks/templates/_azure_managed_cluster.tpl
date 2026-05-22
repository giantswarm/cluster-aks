{{- define "azure-managed-cluster" -}}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureManagedCluster
metadata:
  name: {{ include "cluster-aks.resource.name" . }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
{{- end -}}
