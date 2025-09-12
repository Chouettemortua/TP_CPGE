all: compile run

compile: 
	gcc -Wall -Wextra -Wvla -Werror -fsanitize=address -fsanitize=undefined -o echo.exe echo.c
	gcc -Wall -Wextra -Wvla -Werror -fsanitize=address -fsanitize=undefined -o codage_cesar.exe codage_cesar.c
	gcc -Wall -Wextra -Wvla -Werror -fsanitize=address -fsanitize=undefined -o decrypt.exe decrypt.c
	gcc -Wall -Wextra -Wvla -Werror -fsanitize=address -fsanitize=undefined -o Q5_exo_cryptage.exe Q5_exo_cryptage.c
	gcc -Wall -Wextra -Wvla -Werror -fsanitize=address -fsanitize=undefined -o Q5_exo_decryptage.exe Q5_exo_decryptage.c
	ocamlopt -o cat.exe cat.ml
	ocamlopt -o quine.exe quine.ml
run_old:
	./echo.exe bonjour je teste ce programe en rapide
	./cat.exe cat.ml
	./quine.exe quine.ml
run:
	./codage_cesar.exe entree.txt sortie.txt 3
	./decrypt.exe sortie.txt sortie_post_decrypt.txt 3
	./Q5_exo_cryptage.exe entree_Q5.txt 3 > sortie_Q5.txt
	./Q5_exo_decryptage.exe sortie_Q5.txt 3 > sortie_post_decrypt_Q5.txt
