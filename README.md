# Interop test for HPKE PQ KEMs with OSSL and Go

## Build

The OpenSSL side of things can be built as follows:

``gcc -o hpke hpke.c -I$OSSL/include -L$OSSL -lssl -lcrypto -Wl,-rpath,$OSSL``

Where ``$OSSL`` is the path your openssl root dir, which is on the following branch: https://github.com/slontis/openssl/tree/pq_hpke

The Go side requires Go version >1.26 and is built as follows:

``go build -o hpke_go hpke.go``

## Run

The ``run_tests.sh`` bash script runs tests for all available HPKE suites (Classical, PQ, and Hybrid) and reports results.
Note that the ML-KEM 512 tests will fail as **Go does not implement ML-KEM 512 specifically.**