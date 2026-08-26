{{/*
Cross-field validation. Produces no output — only `fail` calls as side effects.
*/}}
{{- define "validation" -}}
{{- $nodePools := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools -}}
{{- if not $nodePools -}}
{{- fail "global.nodePools must define at least one node pool" -}}
{{- end -}}
{{- $systemPools := list -}}
{{- range $name, $pool := $nodePools -}}
  {{- if eq (default "User" $pool.mode) "System" -}}
    {{- $systemPools = append $systemPools $name -}}
  {{- end -}}
{{- end -}}
{{- if eq (len $systemPools) 0 -}}
{{- fail "at least one node pool in global.nodePools must have mode: System (AKS requires a system pool)" -}}
{{- end -}}
{{- $networking := .Values.global.controlPlane.networking -}}
{{- if eq $networking.networkPlugin "none" -}}
  {{- range $field := list "networkDataplane" "networkMode" "networkPolicy" -}}
    {{- if get $networking $field -}}
{{- fail (printf "global.controlPlane.networking.%s cannot be set when global.controlPlane.networking.networkPlugin is none (BYO CNI); AKS rejects it and networking is provided by the cilium app" $field) -}}
    {{- end -}}
  {{- end -}}
  {{- if not .Values.global.connectivity.network.pods.cidrBlocks -}}
{{- fail "global.connectivity.network.pods.cidrBlocks must be non-empty when global.controlPlane.networking.networkPlugin is none (BYO CNI); it is the pool the cilium app allocates pod IPs from" -}}
  {{- end -}}
{{- end -}}
{{- $vnet := .Values.global.connectivity.network.vnet -}}
{{- if not $vnet.subnetArmId -}}
  {{- if not $vnet.cidrBlocks -}}
{{- fail "global.connectivity.network.vnet.cidrBlocks must be non-empty unless global.connectivity.network.vnet.subnetArmId is set (BYO VNet)" -}}
  {{- end -}}
  {{- if not $vnet.subnet.cidrBlocks -}}
{{- fail "global.connectivity.network.vnet.subnet.cidrBlocks must be non-empty unless global.connectivity.network.vnet.subnetArmId is set (BYO VNet)" -}}
  {{- end -}}
{{- else if $vnet.name -}}
{{- fail "global.connectivity.network.vnet.name is ignored when global.connectivity.network.vnet.subnetArmId is set (BYO VNet); remove one of the two to avoid ambiguous configuration" -}}
{{- end -}}
{{- end -}}
