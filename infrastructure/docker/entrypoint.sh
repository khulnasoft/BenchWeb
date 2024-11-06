#!/bin/bash

set -eo pipefail -u

chown -LR "$USER_ID" /var/run
# Drop permissions of user to match those of the host system
#gosu "$USER_ID" python3 "${FWROOT}/benchmarks/run-tests.py" "$@"
if [[ -z "${FWROOT:-}" ]]; then
    echo "Error: FWROOT environment variable is not set"
    exit 1
fi

PYTHON_SCRIPT="${FWROOT}/benchmarks/run-tests.py"
if [ ! -f "${PYTHON_SCRIPT}" ]; then
    echo "Error: Python script not found at: ${PYTHON_SCRIPT}"
    exit 1
fi

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: $1 command not found"
        exit 1
    fi
}

check_command gosu
check_command python3

if ! gosu "$USER_ID" python3 "$PYTHON_SCRIPT" "$@"; then
    echo "Error: Failed to execute $PYTHON_SCRIPT"
    exit 1
fi