#!/bin/sh
set -e -o pipefail

if ! [ -f "$DATABASE_PATH" ]; then
  sqlite3 "$DATABASE_PATH" < /usr/local/share/pdns/schema.sqlite3.sql

  for ZONEFILE in "${ZONEDIR:=/zones}"/*; do
    if [ -f "$ZONEFILE" ]; then
      ZONENAME=$(basename "$ZONEFILE")
      pdnsutil load-zone $ZONENAME "$ZONEFILE"
      pdnsutil set-meta $ZONENAME SOA-EDIT-API DEFAULT
    fi
  done
fi

exec "$@"
