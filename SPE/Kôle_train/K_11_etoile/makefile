all : compile run
compile :
	gcc -o main.exe -fsanitize=address main.c
	echo "ocamlopt -o mots.exe parser.ml mots.ml"

run :
	./main.exe
	./mots.exe