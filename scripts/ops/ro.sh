#!/usr/bin/env bash
# Ejecuta un script con SQLcl como C##OPS_RO y termina.
# Uso: bash scripts/ops/ro.sh <archivo.sql> [servicio]
set -euo pipefail
source scripts/deployment/env/00-config.sh
source config/.env

SQL_FILE="${1:?Uso: ro.sh <archivo.sql> [servicio]}"
SERVICE="${2:-$SERVICE_CDB}"
[ -f "$SQL_FILE" ] || { echo "No existe $SQL_FILE" >&2; exit 2; }

printf 'CONNECT c##ops_ro/"%s"@//localhost:%s/%s\n@%s\nEXIT\n' \
  "$OPS_RO_PWD" "$PORT_DB" "$SERVICE" "$SQL_FILE" | sql -S /nolog
