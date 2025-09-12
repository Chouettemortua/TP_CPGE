all:	compile run

compile:	TP_14.c test_scan.c
	gcc TP_14.c -o TP_14.exe
	gcc test_scan.c -o test_scan.exe

run:	
	./TP_14.exe <entree.txt >sortie.txt
	./test_scan.exe <entree1.txt >sortie2.txt
