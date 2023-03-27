#!/bin/bash

set -euo pipefail

# Example of values.yaml
# testTypeA:
#   test01.test.es:
#     - "1.1.1.1"
#     - "1.1.1.2"
#     - "1.1.1.3"
#   test01.test.dev:
#     - "2.1.1.1"
#     - "2.1.1.2"
#     - "2.1.1.3"
VALUES_YAML="$( dirname -- ${BASH_SOURCE[0]} )/chart/values.yaml"
PARENT_PATH=".testTypeA"
TEST_CASES=$(yq "$PARENT_PATH"' | keys | @tsv' "$VALUES_YAML")
ERRORS=0

for DOMAIN in $TEST_CASES; do
    echo "Test domain: \"$DOMAIN\""
    for IP in $(yq "$PARENT_PATH.\"$DOMAIN\""' | @tsv' "$VALUES_YAML"); do
        LOGS=$(dig +short "$DOMAIN" A @$1 | grep $IP 2>&1 )
        if [ "$?" -eq 0 ]; then
            echo "✅ Test case for IP $IP passed"
        else
            echo "❌ Test case for IP $IP FAILED"
            echo Logs:
            echo "$LOGS"
            echo
            (( ERRORS++ ))
        fi
    done
done

exit $ERRORS
