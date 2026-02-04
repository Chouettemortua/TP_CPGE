all : compile run
compile :
	ocamlc -I +unix -I +threads unix.cma threads.cma -o TP_11.exe TP_11.ml
run :
	./TP_11.exe
clean :
	rm -f *.cmi *.cmo *.exe