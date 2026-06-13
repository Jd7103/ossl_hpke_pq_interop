OSSL=${HOME}/code/openssl-slontis

all: hpke_ftest_c hpke_ftest_go

hpke_ftest_c: hpke_ftest.c
	gcc -o hpke_ftest_c hpke_ftest.c -I${OSSL}/include -L${OSSL} -lssl -lcrypto -Wl,-rpath,${OSSL}

hpke_ftest_go: hpke_ftest.go
	go build -o hpke_ftest_go hpke_ftest.go

clean:
	rm -f hpke_ftest_c hpke_ftest_go

