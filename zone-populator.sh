#!/bin/bash
set -euo pipefail

DATABASE_PATH=${DATABASE_PATH:=/data/db.sqlite}

if [ -f "$DATABASE_PATH" ]; then
  echo Removing a previously unclean exit...
  rm -v "$DATABASE_PATH"
fi

echo Populating seed database...
sqlite3 "$DATABASE_PATH" < /usr/local/share/pdns/schema.sqlite3.sql

for ZONEFILE in "${ZONEDIR:=/zones}"/*; do
  if [ -f "$ZONEFILE" ]; then
    ZONENAME=$(basename "$ZONEFILE")

    echo "Found zone $ZONENAME!"
    echo "Loading zone file..."
    pdnsutil load-zone $ZONENAME "$ZONEFILE"
  fi
done
