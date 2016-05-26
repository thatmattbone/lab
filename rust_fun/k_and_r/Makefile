
all:
	rustc --lib k_and_r.rc 
	rustc sorting.rs --test -o k_and_r_tests
	rustc sortlines.rs -L .

run: all
	./sortlines lines

clean:
	-rm sortlines
	-rm k_and_r_tests
	-rm *.so

docs:
	rustdoc k_and_r.rc

test:
	fuck
