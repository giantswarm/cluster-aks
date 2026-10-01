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
{{- $cp := .Values.global.controlPlane -}}
{{- if and $cp.disableLocalAccounts (not $cp.aadProfile.managed) -}}
{{- fail "global.controlPlane.disableLocalAccounts requires global.controlPlane.aadProfile.managed: true; AKS only accepts disabling local accounts on Entra-integrated clusters, and without it no client (including CAPZ) can authenticate to the API server" -}}
{{- end -}}
{{- if include "cluster-aks.nodeOSUpgrade.maintenanceWindow.enabled" . -}}
  {{- $mw := .Values.global.providerSpecific.nodeOSUpgrade.maintenanceWindow -}}
  {{- $prefix := "global.providerSpecific.nodeOSUpgrade.maintenanceWindow" -}}
  {{- if not $mw.durationHours -}}
{{- fail (printf "%s.durationHours is required when a maintenance window is configured" $prefix) -}}
  {{- end -}}
  {{- if not $mw.startTime -}}
{{- fail (printf "%s.startTime is required when a maintenance window is configured" $prefix) -}}
  {{- end -}}
  {{- /* Fields each schedule type needs; the schema only checks their types and ranges. */ -}}
  {{- $requiredFields := dict
        "daily" (list "intervalDays")
        "weekly" (list "dayOfWeek" "intervalWeeks")
        "absoluteMonthly" (list "dayOfMonth" "intervalMonths")
        "relativeMonthly" (list "dayOfWeek" "intervalMonths" "weekIndex") -}}
  {{- $types := list -}}
  {{- range $type, $schedule := ($mw.schedule | default dict) -}}
    {{- if $schedule -}}
      {{- $types = append $types $type -}}
      {{- range $field := get $requiredFields $type -}}
        {{- if not (hasKey $schedule $field) -}}
{{- fail (printf "%s.schedule.%s.%s is required" $prefix $type $field) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- if ne (len $types) 1 -}}
{{- fail (printf "%s.schedule must set exactly one of daily, weekly, absoluteMonthly or relativeMonthly, got: %s" $prefix (join ", " $types | default "none")) -}}
  {{- end -}}
{{- end -}}
{{- end -}}
