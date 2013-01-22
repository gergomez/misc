#CFLAGS=-g -gstabs
CFLAGS=-O3
TARGETS=graph twocolor findcycle findarticulate findsubsets findperms findpaths sudoku wgraph tsp
CC=gcc

all: $(TARGETS)

graph: graph.c queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ graph.c queue.o

wgraph: wgraph.c
	$(CC) $(CFLAGS) -DTEST -o $@ wgraph.c

tsp: tsp.c
	$(CC) $(CFLAGS) -DTEST -o $@ tsp.c

twocolor: twocolor.c graph.o queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ twocolor.c graph.o queue.o

findcycle: findcycle.c graph.o queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ findcycle.c graph.o queue.o

findarticulate: findarticulate.c graph.o queue.o
	$(CC) $(CFLAGS) -DTEST -o $@ findarticulate.c graph.o queue.o
findsubsets: backtrack.c
	$(CC) $(CFLAGS) -DSUBSETS -o $@ backtrack.c
findperms: backtrack.c
	$(CC) $(CFLAGS) -DPERMS -o $@ backtrack.c
findpaths: backtrack.c graph.o queue.o
	$(CC) $(CFLAGS) -DPATHS -o $@ backtrack.c graph.o queue.o
sudoku: backtrack.c
	$(CC) $(CFLAGS) -DSUDOKU -o $@ backtrack.c
%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -f *.o $(TARGETS)

