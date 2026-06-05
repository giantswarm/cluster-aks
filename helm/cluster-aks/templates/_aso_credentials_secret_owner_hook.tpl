{{/*
Helm post-install/post-upgrade/post-rollback hook that patches the ASO
credentials Secret and the AzureClusterIdentity CR with an ownerReference
pointing at the AzureASOManagedCluster. The Secret has
`helm.sh/resource-policy: keep` and therefore outlives `helm uninstall`; the
ownerReference ensures both dependents are garbage-collected when the
cluster CR itself is deleted.

Rendered only when an ASO credentials Secret is rendered in the first place
(i.e. global.providerSpecific.asoAuthentication.clientID is set), which is
the same condition under which the AzureClusterIdentity is rendered.
*/}}
{{- define "aso-credentials-secret-owner-hook" -}}
{{- if not (include "cluster-aks.aso.credentialSecretName" .) -}}
{{- else -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
{{- $secretName := include "cluster-aks.aso.credentialSecretName" . -}}
{{- $identityName := include "cluster-aks.azureClusterIdentity.name" . -}}
{{- $hookName := printf "%s-aso-credentials-owner" $clusterName -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $hookName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/hook": post-install,post-upgrade,post-rollback
    "helm.sh/hook-weight": "-10"
    "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: {{ $hookName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/hook": post-install,post-upgrade,post-rollback
    "helm.sh/hook-weight": "-10"
    "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
rules:
  - apiGroups: ["infrastructure.cluster.x-k8s.io"]
    resources: ["azureasomanagedclusters"]
    resourceNames: [{{ $clusterName | quote }}]
    verbs: ["get"]
  - apiGroups: ["infrastructure.cluster.x-k8s.io"]
    resources: ["azureclusteridentities"]
    resourceNames: [{{ $identityName | quote }}]
    verbs: ["get", "patch"]
  - apiGroups: [""]
    resources: ["secrets"]
    resourceNames: [{{ $secretName | quote }}]
    verbs: ["get", "patch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: {{ $hookName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/hook": post-install,post-upgrade,post-rollback
    "helm.sh/hook-weight": "-10"
    "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: {{ $hookName }}
subjects:
  - kind: ServiceAccount
    name: {{ $hookName }}
    namespace: {{ .Release.Namespace }}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ $hookName }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
  annotations:
    "helm.sh/hook": post-install,post-upgrade,post-rollback
    "helm.sh/hook-weight": "0"
    "helm.sh/hook-delete-policy": before-hook-creation,hook-succeeded
spec:
  backoffLimit: 5
  ttlSecondsAfterFinished: 600
  template:
    metadata:
      labels:
        {{- include "labels.common" . | nindent 8 }}
    spec:
      restartPolicy: OnFailure
      serviceAccountName: {{ $hookName }}
      containers:
        - name: kubectl
          image: "{{ .Values.internal.kubectlImage.registry }}/{{ .Values.internal.kubectlImage.name }}:{{ .Values.internal.kubectlImage.tag }}"
          command: ["/bin/sh", "-c"]
          args:
            - |
              set -eu
              owner_uid=$(kubectl get azureasomanagedcluster {{ $clusterName }} \
                -n {{ .Release.Namespace }} \
                -o jsonpath='{.metadata.uid}')
              if [ -z "$owner_uid" ]; then
                echo "AzureASOManagedCluster {{ $clusterName }} has no UID yet" >&2
                exit 1
              fi
              owner_ref="{\"metadata\":{\"ownerReferences\":[{\"apiVersion\":\"infrastructure.cluster.x-k8s.io/v1beta1\",\"kind\":\"AzureASOManagedCluster\",\"name\":\"{{ $clusterName }}\",\"uid\":\"$owner_uid\"}]}}"
              kubectl patch secret {{ $secretName }} \
                -n {{ .Release.Namespace }} \
                --type=merge \
                -p "$owner_ref"
              kubectl patch azureclusteridentity {{ $identityName }} \
                -n {{ .Release.Namespace }} \
                --type=merge \
                -p "$owner_ref"
{{- end -}}
{{- end -}}
