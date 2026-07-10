{{- define "aso-credentials-secret" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "cluster-aks.aso.credentialSecretName" . }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/resource-policy": keep
type: Opaque
stringData:
  {{- include "cluster-aks.aso.credentialsSecretData" . | nindent 2 }}
{{- end -}}
