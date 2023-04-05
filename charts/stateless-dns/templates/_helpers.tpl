{{/*
Expand the name of the chart.
*/}}
{{- define "stateless-dns.name" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "stateless-dns.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name }}
{{- end }}
{{- end }}
{{- end }}


{{- /*
Create a default fully qualified app name which always include the suffix, truncating the name if needed.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If suffix is too long it gets truncated but it always takes precedence over name, so a 63 chars suffix would suppress the name.
Usage:
{{ include "stateless-dns.fullname.withSuffix" ( dict "context" . "suffix" "my-suffix" ) }}
*/ -}}
{{- define "stateless-dns.fullname.withSuffix" -}}
{{- $suffix := .suffix | trunc 63 | trimSuffix "-" -}}
{{- $maxLen := (max (sub 63 (add1 (len $suffix))) 0) -}} {{- /* We prepend "-" to the suffix so an additional character is needed */ -}}

{{- $newName := include "stateless-dns.fullname" .context | trunc ($maxLen | int) | trimSuffix "-"  -}}
{{- if $newName -}}
{{- printf "%s-%s" $newName $suffix -}}
{{- else -}}
{{ $suffix }}
{{- end -}}

{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "stateless-dns.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "stateless-dns.labels" -}}
helm.sh/chart: {{ include "stateless-dns.chart" . }}
{{ include "stateless-dns.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "stateless-dns.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stateless-dns.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: external-dns
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "stateless-dns.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "stateless-dns.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the secret containing the API Key
*/}}
{{- define "stateless-dns.secret.name" -}}
{{- default (include "stateless-dns.fullname" .) .Values.pdns.apiKeySecret.name }}
{{- end }}


{{/*
Create the key of the secret containing the API Key
*/}}
{{- define "stateless-dns.secret.key" -}}
{{- default "api-key" .Values.pdns.apiKeySecret.key }}
{{- end }}
