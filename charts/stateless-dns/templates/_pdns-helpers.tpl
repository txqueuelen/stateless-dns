{{/*
Expand the name of PowerDNS deployment.
*/}}
{{- define "pdns.name" -}}
{{- default "power-dns" .Values.pdns.nameOverride }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pdns.fullname" -}}
{{- if .Values.pdns.fullnameOverride }}
{{- .Values.pdns.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "pdns.name" . }}
{{- if contains $name (include "stateless-dns.fullname" .) }}
{{- (include "stateless-dns.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" (include "stateless-dns.fullname" .) $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "pdns.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stateless-dns.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: powerdns
{{- end }}


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
