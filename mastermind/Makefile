#CFLAGS=-O2 -g -fomit-frame-pointer -Wall
CFLAGS=-O2 -Wall
CC=icc
LDFLAGS=

all: mastermind mmind-auto

clean:
	rm -f mastermind mmind-auto

t: mastermind
	./mastermind 4 3

g: mastermind
	gdb ./mastermind 
