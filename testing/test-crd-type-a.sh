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

# IP of the DNS we are testing
export DNS_IP="$1"
# Get the values.yaml of the testing chart
export VALUES_YAML="$( dirname -- ${BASH_SOURCE[0]} )/chart/values.yaml"
# Get the values for this test
export TEST_PATH=".testTypeA"
# Count errors
ERRORS=0

# Gets the keys of the TEST_PATH. These domains are the ones being tested.
get_domains_to_test () {
    yq 'eval(env(TEST_PATH)) | keys | @tsv' "$VALUES_YAML"
}

# Given a domain ($1), this returns a list of IPs ready to iterate over them
get_ips_from_domain () {
    DOMAIN="$1" \
    yq 'eval("${TEST_PATH}.\"${DOMAIN}\"" | envsubst(nu,ne)) | @tsv' "$VALUES_YAML"
}

# Given a domain ($1) and a IP ($2), this returns if the DNS ($DNS_IP) resolves the domain AT LEAST as IP.
test_domain_has_ip () {
    dig +short "$1" A "@$DNS_IP" | grep $2 2>&1
    return $?
}

for DOMAIN in $(get_domains_to_test); do
    echo "Test domain: \"$DOMAIN\""

    for IP in $(get_ips_from_domain $DOMAIN); do
        if test_domain_has_ip $DOMAIN $IP; then
            echo "✅ Test case for IP $IP passed"
        else
            echo "❌ Test case for IP $IP FAILED"
            (( ERRORS++ ))
        fi
    done
done

exit $ERRORS
