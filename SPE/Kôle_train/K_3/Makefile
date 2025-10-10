main: *.c
	gcc -o main.exe *.c -lm

main_safe : *.c
	gcc -o main.exe -g -Wall -Wextra -fsanitize=address *.c -lm

clean:
	rm -f *.o *.exe

run: main
	./main.exe

all: main run