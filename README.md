# Interop test for HPKE PQ KEMs with OSSL and Go

## Build

``make`` should work:-)

The OpenSSL side of things can be built as follows:

``gcc -o hpke_ftest_c hpke_ftest.c -I$OSSL/include -L$OSSL -lssl -lcrypto -Wl,-rpath,$OSSL``

Where ``$OSSL`` is the path your openssl root dir, which is on the following branch: https://github.com/slontis/openssl/tree/pq_hpke

The Go side requires Go version >1.26 and is built as follows:

``go build -o hpke_ftest_go hpke_ftest.go``

## Run

The ``run_tests.sh`` bash script runs tests for all available HPKE suites (Classical, PQ, and Hybrid) and reports results.
Note that the ML-KEM 512 tests will fail as **Go does not implement ML-KEM 512 specifically.**

You can set an environment variable ``$WORKDIR`` where temporary test files will be created.
