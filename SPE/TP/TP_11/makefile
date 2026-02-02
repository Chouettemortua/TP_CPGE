all : compile run
compile_src :
	@echo "Compiling source files..."
	gcc lecture.c -o lecture.exe
	gcc prod-conso.c -o prod-conso.exe
	gcc texte_aleatoire.c -o texte_aleatoire.exe
	@echo "Source files compilation finished."
compile :
	@echo "Compiling TP_11.c..."
	gcc -o TP_11.exe TP_11.c 
	@echo "TP_11 compilation finished."
run :
	@echo "Running TP_11..."
	./TP_11.exe
clean :
	@echo "Cleaning up..."
	rm -f TP_11.exe
	rm -f lecture.exe
	rm -f prod-conso.exe
	rm -f texte_aleatoire.exe
	@echo "Cleanup finished."