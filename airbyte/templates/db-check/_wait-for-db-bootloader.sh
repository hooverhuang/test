#!/bin/bash
{{- $boot := index .Subcharts "airbyte-bootloader" -}}

MINIO_NAME={{ template "minio.fullname" .Subcharts.minio }}
POSTGRESQL_NAME={{ template "postgresql.fullname" .Subcharts.postgresql }}
BOOTLOADER={{ template "common.names.fullname" $boot }}
NAMESPACE={{ .Release.Namespace }}

echo 'start checking minio deployment ...'
kubectl wait --for=condition=available --timeout=30m deployment/$MINIO_NAME  --namespace=$NAMESPACE
echo 'start checking postgresql statefulset ...'
kubectl rollout status --watch --timeout=30m statefulset/$POSTGRESQL_NAME --namespace=$NAMESPACE

