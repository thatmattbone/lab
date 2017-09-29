all: mylisp.c core.o eval.o reader tests
	gcc `pkg-config --cflags --libs glib-2.0` -o mylisp mylisp.c core.o

core.o: core.c
	gcc -c core.c

eval.o: eval.c
	gcc `pkg-config --cflags --libs glib-2.0` -c eval.c

printer.o: printer.c
	gcc -c printer.c

reader: reader.l reader.y core.o eval.o printer.o
	bison -d reader.y
	flex reader.l
	gcc `pkg-config --cflags --libs glib-2.0` -c lex.yy.c
	gcc `pkg-config --cflags --libs glib-2.0` -c reader.tab.c 
	gcc `pkg-config --cflags --libs glib-2.0` -lfl -o reader lex.yy.o reader.tab.o core.o eval.o printer.o 

tests: tests.c core.o eval.o
	gcc `pkg-config --cflags --libs glib-2.0` -o tests tests.c core.o eval.o

clean:
	-rm *.o
	-rm *~
	-rm lex.yy.c
	-rm reader
	-rm mylisp
	-rm tests
	-rm *.tab.*
	-rm *.yy.*
	-rm reader.c
