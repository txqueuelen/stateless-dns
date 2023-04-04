{{/*
Create the name of the secret containing the API Key
*/}}
{{- define "pdns.secret.name" -}}
{{- default (include "stateless-dns.fullname" .) .Values.pdns.apiKeySecret.name }}
{{- end }}


{{/*
Create the key of the secret containing the API Key
*/}}
{{- define "pdns.secret.key" -}}
{{- default "api-key" .Values.pdns.apiKeySecret.key }}
{{- end }}
