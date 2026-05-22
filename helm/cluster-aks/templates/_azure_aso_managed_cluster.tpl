{{- define "azure-aso-managed-cluster" -}}
{{- $ps := .Values.global.providerSpecific -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureASOManagedCluster
metadata:
  name: {{ $clusterName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
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
        azureName: {{ $ps.resourceGroupName | default $clusterName | quote }}
        location: {{ required "global.providerSpecific.location is required" $ps.location | quote }}
        {{- with .Values.global.controlPlane.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
{{- end -}}
