graph: graph.c queue.o
	$(CC) -DTEST -o graph graph.c queue.o

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)
