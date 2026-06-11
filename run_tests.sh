#!/usr/bin/env bash
set -euo pipefail

C_BIN="$(realpath ./hpke)"
GO_BIN="$(realpath ./hpke_go)"
WORKDIR="$(mktemp -d)"
PASSED=0
FAILED=0

SUITES=(x25519 p256 mlkem512 mlkem768 mlkem1024 xwing mlkem768p256 mlkem1024p384)

run_step() {
    local label="$1"
    local dir="$2"
    local logfile="$dir/${label##*/}.log"
    shift 2
    if (cd "$dir" && "$@") > "$logfile" 2>&1; then
        echo "PASS  $label"
        sed 's/^/      /' "$logfile"
        PASSED=$(( PASSED + 1 ))
    else
        echo "FAIL  $label"
        sed 's/^/      /' "$logfile"
        FAILED=$(( FAILED + 1 ))
    fi
}

for suite in "${SUITES[@]}"; do
    dir="$WORKDIR/$suite"
    mkdir -p "$dir"

    run_step "$suite/go_keygen"  "$dir" "$GO_BIN" -suite "$suite" keygen
    run_step "$suite/c_keygen"   "$dir" "$C_BIN"  -suite "$suite" keygen
    run_step "$suite/go_encrypt" "$dir" "$GO_BIN" -suite "$suite" encrypt
    run_step "$suite/c_encrypt"  "$dir" "$C_BIN"  -suite "$suite" encrypt
    run_step "$suite/c_decrypt"  "$dir" "$C_BIN"  -suite "$suite" decrypt
    run_step "$suite/go_decrypt" "$dir" "$GO_BIN" -suite "$suite" decrypt
done

TOTAL=$(( PASSED + FAILED ))
echo ""
echo "$PASSED / $TOTAL passed"
[[ $FAILED -eq 0 ]]