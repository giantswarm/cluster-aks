{{- define "azure-aso-managed-machine-pools" -}}
{{- $root := . -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
{{- $first := true -}}
{{- range $poolName, $pool := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools }}
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
        {{- with $root.Values.global.providerSpecific.asoAuthenticationSecretName }}
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
        {{- with $pool.osType | default "Linux" }}
        osType: {{ . }}
        {{- end }}
        {{- with $pool.osDiskSizeGB | default 30 }}
        osDiskSizeGB: {{ . }}
        {{- end }}
        {{- with $pool.osDiskType | default "Managed" }}
        osDiskType: {{ . }}
        {{- end }}
        {{- with $pool.maxPods }}
        maxPods: {{ . }}
        {{- end }}
        {{- with $pool.availabilityZones | default (list "1" "2" "3") }}
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
        enableAutoScaling: {{ $pool.enableAutoScaling | default true }}
        {{- with $pool.count }}
        count: {{ . }}
        {{- end }}
        {{- if and (hasKey $pool "minSize") (hasKey $pool "maxSize") }}
        minCount: {{ $pool.minSize | default 1 }}
        maxCount: {{ $pool.maxSize | default 2 }}
        {{- end }}
        {{- with $pool.scaleSetPriority }}
        scaleSetPriority: {{ . }}
        {{- end }}
        {{- if and (eq ($pool.scaleSetPriority | default "Regular") "Spot") $pool.spotMaxPrice }}
        spotMaxPrice: {{ $pool.spotMaxPrice }}
        {{- end }}
        {{- if include "cluster-aks.vnet.byo" $root }}
        vnetSubnetReference:
          armId: {{ $root.Values.global.connectivity.network.vnet.subnetArmId | quote }}
        {{- else }}
        vnetSubnetReference:
          group: network.azure.com
          kind: VirtualNetworksSubnet
          name: {{ include "cluster-aks.subnet.crName" $root }}
        {{- end }}
        {{- with $pool.additionalTags }}
        tags:
          {{- toYaml . | nindent 10 }}
        {{- end }}
{{- end }}
{{- end -}}
