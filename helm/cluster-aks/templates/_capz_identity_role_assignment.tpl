{{/*
Grants the management cluster's CAPZ identity cluster-admin in the workload
cluster through Azure RBAC. CAPZ reaches the API server with an Entra token
issued for that identity once local accounts are disabled, so without this
grant it cannot reconcile the cluster.

Crossplane rather than ASO: CAPZ's ASO installation ships no
authorization.azure.com CRDs. The role assignment is scoped to the resource
group, which holds only this cluster, and is removed together with the Helm
release.
*/}}
{{- define "capz-identity-role-assignment" -}}
{{- $ps := .Values.global.providerSpecific -}}
apiVersion: authorization.azure.upbound.io/v1beta1
kind: RoleAssignment
metadata:
  name: {{ include "cluster-aks.resource.name" . }}-capz-aks-rbac-cluster-admin
  labels:
    {{- include "labels.common" . | nindent 4 }}
spec:
  forProvider:
    principalId: {{ include "cluster-aks.capzIdentity.principalId" . | quote }}
    principalType: ServicePrincipal
    # Azure Kubernetes Service RBAC Cluster Admin
    roleDefinitionId: {{ printf "/subscriptions/%s/providers/Microsoft.Authorization/roleDefinitions/b1ff04bb-8a4e-4dc4-8eb5-8693973ce19b" $ps.subscriptionId | quote }}
    scope: {{ printf "/subscriptions/%s/resourceGroups/%s" $ps.subscriptionId (include "cluster-aks.resourceGroup.name" .) | quote }}
  providerConfigRef:
    # The management cluster's ProviderConfig authenticates as the CAPZ identity, which needs
    # User Access Administrator on the workload cluster's subscription to create the assignment.
    name: {{ .Values.global.managementCluster }}
{{- end -}}
