all:	euler.exe run

graph.o:  graph.c
	gcc -c -o graph.o graph.c
stack.o:  stack.c
	gcc -c -o stack.o stack.c

euler.o:  euler.c
	gcc -c -o euler.o euler.c

euler.exe:  stack.o graph.o euler.o
	gcc -o euler.exe stack.o graph.o euler.o

run:
	cat g3.txt | ./euler.exe
# on peut aussi faire
# ./euler.exe < g3.txt  # redirection d'entrée standard