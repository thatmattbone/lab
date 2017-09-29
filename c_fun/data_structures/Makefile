CFLAGS=-g -Wall -O3 -std=gnu11 `pkg-config --cflags glib-2.0`
LDLIBS=`pkg-config --libs glib-2.0`

PROGRAM=linkedlist
OBJECTS=linkedlist.o

linkedlist: $(OBJECTS)

linkedlist_test: $(OBJECTS)

clean:
	rm -f $(OBJECTS)
	rm -f linkedlist_driver
	rm -f linkedlist_test
