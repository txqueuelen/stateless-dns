#!/bin/sh
set -e -o pipefail

DATABASE_PATH=${DATABASE_PATH:=/data/db.sqlite}

rm "$DATABASE_PATH" 2> /dev/null || true
sqlite3 "$DATABASE_PATH" < /usr/local/share/pdns/schema.sqlite3.sql

for ZONEFILE in "${ZONEDIR:=/zones}"/*; do
  if [ -f "$ZONEFILE" ]; then
    ZONENAME=$(basename "$ZONEFILE")
    pdnsutil load-zone $ZONENAME "$ZONEFILE"
    pdnsutil set-meta $ZONENAME SOA-EDIT-API DEFAULT
  fi
done

exec "$@"
