CFLAGS=-g -gstabs
TARGETS=graph twocolor findcycle findarticulate
CC=gcc

all: $(TARGETS)

graph: graph.c queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ graph.c queue.o

twocolor: twocolor.c graph.o queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ twocolor.c graph.o queue.o

findcycle: findcycle.c graph.o queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ findcycle.c graph.o queue.o

findarticulate: findarticulate.c graph.o queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ findarticulate.c graph.o queue.o
%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -f *.o $(TARGETS)

