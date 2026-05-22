{{- define "azure-managed-machine-pools" -}}
{{- $root := . -}}
{{- $clusterName := include "cluster-aks.resource.name" . -}}
{{- range $poolName, $pool := .Values.global.nodePools }}
---
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: AzureManagedMachinePool
metadata:
  name: {{ $clusterName }}-{{ $poolName }}
  namespace: {{ $root.Release.Namespace }}
  labels:
    {{- include "labels.common" $root | nindent 4 }}
    giantswarm.io/machine-pool: {{ $clusterName }}-{{ $poolName }}
spec:
  name: {{ $poolName | quote }}
  mode: {{ $pool.mode | default "User" }}
  sku: {{ required (printf "vmSize is required for node pool %q" $poolName) $pool.vmSize | quote }}
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
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $pool.nodeLabels }}
  nodeLabels:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $pool.taints }}
  taints:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if and (hasKey $pool "minSize") (hasKey $pool "maxSize") }}
  scaling:
    minSize: {{ $pool.minSize }}
    maxSize: {{ $pool.maxSize }}
  {{- end }}
  {{- with $pool.scaleSetPriority }}
  scaleSetPriority: {{ . }}
  {{- end }}
  {{- if and (eq ($pool.scaleSetPriority | default "Regular") "Spot") $pool.spotMaxPrice }}
  spotMaxPrice: {{ $pool.spotMaxPrice | quote }}
  {{- end }}
  {{- with $pool.subnetName }}
  subnetName: {{ . | quote }}
  {{- end }}
  {{- with $pool.additionalTags }}
  additionalTags:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end -}}
