CXX=g++
LIBS= 

binarytree:
	$(CXX) -c -o binarytree.o binarytree.cpp
	$(CXX) -c -o main.o main.cpp 
	$(CXX) -o binarytree main.o binarytree.o $(LIBS)

clean:
	-rm *.o
	-rm binarytree
