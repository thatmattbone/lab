#include <iostream>
#include "binarytree.h"

using namespace std;

int main(int argc, char *argv[]) {
  Node *root = new Node(5);
  cout << "root value: " << root->getData();

  delete root;
}


