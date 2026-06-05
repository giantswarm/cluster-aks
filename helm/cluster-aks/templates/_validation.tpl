{{/*
Cross-field validation. Produces no output — only `fail` calls as side effects.
*/}}
{{- define "validation" -}}
{{- if not .Values.global.nodePools -}}
{{- fail "global.nodePools must define at least one node pool" -}}
{{- end -}}
{{- $systemPools := list -}}
{{- range $name, $pool := .Values.global.nodePools -}}
  {{- if eq (default "User" $pool.mode) "System" -}}
    {{- $systemPools = append $systemPools $name -}}
  {{- end -}}
{{- end -}}
{{- if eq (len $systemPools) 0 -}}
{{- fail "at least one node pool in global.nodePools must have mode: System (AKS requires a system pool)" -}}
{{- end -}}
{{- $vnet := .Values.global.connectivity.network.vnet -}}
{{- if not $vnet.subnetArmId -}}
  {{- if not $vnet.cidrBlocks -}}
{{- fail "global.connectivity.network.vnet.cidrBlocks must be non-empty unless global.connectivity.network.vnet.subnetArmId is set (BYO VNet)" -}}
  {{- end -}}
  {{- if not $vnet.subnet.cidrBlocks -}}
{{- fail "global.connectivity.network.vnet.subnet.cidrBlocks must be non-empty unless global.connectivity.network.vnet.subnetArmId is set (BYO VNet)" -}}
  {{- end -}}
{{- end -}}
{{- end -}}
