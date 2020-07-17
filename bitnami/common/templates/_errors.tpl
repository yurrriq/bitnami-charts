{{/* vim: set filetype=mustache: */}}
{{/*
Through error when upgrading using empty passwords values that must not be empty.
Usage:
{{ include "common.errors.password.empty" (dict "required" (list "mariadb.password" "app.password") "passwords" "instructions" "context" $) }}
*/}}
{{- define "common.errors.password.empty" -}}
{{- if .context.Release.IsUpgrade -}}
  {{- $validationErrors := include "common.validations.values.empty" . -}}

  {{- if $validationErrors -}}
    {{- $passwordSection := "" -}}
    {{- if .passwords -}}
      {{- $passwordSection = printf "Getting password values:\n\n%s" .passwords -}}
    {{- end -}}

    {{- $errorString := "\nPASSWORDS ERROR: you must provide your current passwords when upgrade the release%s\n\n%s" -}}
    {{- printf $errorString $validationErrors $passwordSection | fail -}}
  {{- end -}}
{{- end -}}
{{- end -}}

