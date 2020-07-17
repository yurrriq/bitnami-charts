{{/* vim: set filetype=mustache: */}}
{{/*
Print instructions to get a secret value.
Usage:
{{ include "common.notetxt.secret.getvalue" (dict "varname" "MY_ENVVAR" "secret" "secret-name" "field" "secret-value-field" "context" $) }}
*/}}
{{- define "common.notetxt.secret.getvalue" -}}
export {{ .varname }}=$(kubectl get secret --namespace {{ .context.Release.Namespace }} {{ .secret }} -o jsonpath="{.data.{{ .field }}}" | base64 --decode)
{{- end -}}
