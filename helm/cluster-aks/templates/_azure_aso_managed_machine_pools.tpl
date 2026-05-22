{{- define "azure-aso-managed-machine-pools" -}}
{{- $root := . -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
{{- $first := true -}}
{{- range $poolName, $pool := .Values.global.nodePools }}
{{- if $first }}{{- $first = false -}}{{- else }}
---
{{- end }}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureASOManagedMachinePool
metadata:
  name: {{ $clusterName }}-{{ $poolName }}
  namespace: {{ $root.Release.Namespace }}
  labels:
    {{- include "labels.common" $root | nindent 4 }}
    giantswarm.io/machine-pool: {{ $clusterName }}-{{ $poolName }}
spec:
  resources:
    - apiVersion: containerservice.azure.com/v1api20240901
      kind: ManagedClustersAgentPool
      metadata:
        name: {{ $clusterName }}-{{ $poolName }}
        {{- with (include "cluster-aks.aso.credentialSecretName" $root) }}
        annotations:
          serviceoperator.azure.com/credential-from: {{ . | quote }}
        {{- end }}
      spec:
        owner:
          name: {{ $clusterName }}
        azureName: {{ $poolName | quote }}
        mode: {{ $pool.mode | default "User" }}
        type: VirtualMachineScaleSets
        vmSize: {{ required (printf "vmSize is required for node pool %q" $poolName) $pool.vmSize | quote }}
        {{- with $pool.osType }}
        osType: {{ . }}
        {{- end }}
        {{- with $pool.osDiskSizeGB }}
        osDiskSizeGB: {{ . }}
        {{- end }}
        {{- with $pool.osDiskType }}
        osDiskType: {{ . }}
        {{- end }}
        {{- with $pool.maxPods }}
        maxPods: {{ . }}
        {{- end }}
        {{- with $pool.availabilityZones }}
        availabilityZones:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        {{- with $pool.nodeLabels }}
        nodeLabels:
          {{- toYaml . | nindent 10 }}
        {{- end }}
        {{- with $pool.taints }}
        nodeTaints:
          {{- range . }}
          - {{ printf "%s=%s:%s" .key (.value | default "") .effect | quote }}
          {{- end }}
        {{- end }}
        {{- if and (hasKey $pool "minSize") (hasKey $pool "maxSize") }}
        enableAutoScaling: false
        minCount: {{ $pool.minSize }}
        maxCount: {{ $pool.maxSize }}
        {{- end }}
        {{- with $pool.scaleSetPriority }}
        scaleSetPriority: {{ . }}
        {{- end }}
        {{- if and (eq ($pool.scaleSetPriority | default "Regular") "Spot") $pool.spotMaxPrice }}
        spotMaxPrice: {{ $pool.spotMaxPrice }}
        {{- end }}
        {{- with $pool.subnetArmId }}
        vnetSubnetReference:
          armId: {{ . | quote }}
        {{- end }}
        {{- with $pool.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
{{- end }}
{{- end -}}
