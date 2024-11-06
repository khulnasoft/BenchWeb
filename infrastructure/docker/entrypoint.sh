#!/bin/bash

set -eo pipefail -u

chown -LR "$USER_ID" /var/run
# Drop permissions of user to match those of the host system
#gosu "$USER_ID" python3 "${FWROOT}/benchmarks/run-tests.py" "$@"
if [ -z "${FWROOT:-}" ]; then
    echo "Error: FWROOT environment variable is not set"
    exit 1
fi

PYTHON_SCRIPT="${FWROOT}/benchmarks/run-tests.py"
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: Python script not found at: $PYTHON_SCRIPT"
    exit 1
fi

# Check if gosu is available
if ! command -v gosu >/dev/null 2>&1; then
    echo "Error: gosu command not found"
    exit 1
fi

# Check if python3 is available
if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 command not found"
    exit 1
fi

gosu "$USER_ID" python3 "$PYTHON_SCRIPT" "$@"