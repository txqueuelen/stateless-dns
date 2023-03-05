{{/*
Expand the name of external-dns deployment.
*/}}
{{- define "external-dns.name" -}}
{{- default "external-dns" .Values.externalDNS.nameOverride }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "external-dns.fullname" -}}
{{- if .Values.externalDNS.fullnameOverride }}
{{- .Values.externalDNS.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "stateless-dns.fullname" . }}
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
{{- define "external-dns.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stateless-dns.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: external-dns
{{- end }}
