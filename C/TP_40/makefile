all : compile run

compile: 

	gcc -o squelette.exe -Werror -Wall -Wextra squelette.c stack.c bitpacking.c

run:
	./squelette.exe C moby_dick.txt moby_dick_comp.txt
	./squelette.exe D moby_dick_comp.txt moby_dick_decomp.txt