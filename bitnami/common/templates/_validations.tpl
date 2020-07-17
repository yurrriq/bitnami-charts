{{/* vim: set filetype=mustache: */}}
{{/*
Validate values must not be empty.
Usage:
{{ include "common.validations.values.empty" (dict "required" (list "mariadb.password" "app.password") "context" $) }}
*/}}
{{- define "common.validations.values.empty" -}}
{{- range .required -}}
  {{- $valueKey := . -}}

  {{- $valueKeyArray := splitList "." $valueKey -}}
  {{- $value := "" -}}
  {{- $latestObj := $.context.Values -}}
  {{- range $valueKeyArray -}}
    {{- if not $latestObj -}}
      {{- printf "please review the entire path of '%s' exists in values" $valueKey | fail -}}
    {{- end -}}

    {{- $value = ( index $latestObj . ) -}}
    {{- $latestObj = $value -}}
  {{- end -}}

  {{- if not $value -}}
  {{- printf "\n    '%s' must not be empty, please add '--set %s=your_value' to the command" $valueKey $valueKey -}}
  {{- end -}}
{{- end -}}
{{- end -}}
