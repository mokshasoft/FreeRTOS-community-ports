test: build/exec/test1

build/exec/test.scm: test.idr
	idris2 --cg gambit test.idr -o test

build/exec/test.c: build/exec/test.scm
	gsc -c -o build/exec/test.c build/exec/test.scm

build/exec/test1: build/exec/test.c
	gsc -exe -cc-options -Wno-implicit-function-declaration -ld-options ~/.idris2/idris2-0.2.1/lib/libidris2_support.a -o build/exec/test1 build/exec/test.c

clean:
	rm -rf build
