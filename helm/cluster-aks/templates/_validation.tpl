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
{{- end -}}
