#!/bin/sh
set -e -o pipefail

function die () {
  echo "$@"
  exit 1
}

[ -f /etc/pdns/pdns.conf ] || \
  die "No configuration file found at /etc/pdns/pdns.conf. Please, use the standard location."

[ $(grep -E '^launch=gsqlite3$' /etc/pdns/pdns.conf | wc -l) -eq 1 ] || \
  die "This image is meant to be used with sqlite backend"

DATABASE=$(grep -E '^gsqlite3-database=' /etc/pdns/pdns.conf | cut -d= -f2-)

if ! [ -f "$DATABASE" ]; then
  sqlite3 "$DATABASE" < /usr/local/share/pdns/schema.sqlite3.sql

  for ZONEFILE in "${ZONEDIR:=/zones}"/*; do
    if [ -f "$ZONEFILE" ]; then
      ZONENAME=$(basename "$ZONEFILE")
      pdnsutil load-zone $ZONENAME "$ZONEFILE"
      pdnsutil set-meta $ZONENAME SOA-EDIT-API DEFAULT
    fi
  done
fi

exec "$@"
