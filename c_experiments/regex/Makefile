CFLAGS=-g -Wall -O3 -std=gnu11 `pkg-config --cflags glib-2.0`
LDLIBS=`pkg-config --libs glib-2.0`

PROGRAM=regex_driver
OBJECTS=regex.o

regex_driver: $(OBJECTS)

regex_test: $(OBJECTS)

clean:
	rm -f $(OBJECTS)
	rm -f regex_driver
	rm -f regex_test
