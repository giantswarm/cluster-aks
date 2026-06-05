{{- define "aso-credentials-secret" -}}
{{- $auth := .Values.global.providerSpecific.asoAuthentication -}}
{{- if $auth.clientID -}}
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
  AZURE_SUBSCRIPTION_ID: {{ $auth.subscriptionID | quote }}
  AZURE_TENANT_ID: {{ $auth.tenantID | quote }}
  AZURE_CLIENT_ID: {{ $auth.clientID | quote }}
  AUTH_MODE: workloadidentity
{{- end -}}
{{- end -}}
