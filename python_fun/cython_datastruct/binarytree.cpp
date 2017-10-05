//#include <iostream>
//#include <map>
//#include <string>
#include <utility>
#include "binarytree.h"

using namespace std;

Node::Node(int data) {
  Node::data = data;
  left = NULL;
  right = NULL;
}

Node::~Node() { 
  if(left != NULL) {
    delete left;
  }
  if(right != NULL) {
    delete right;
  }
}

Node* Node::getLeft() {
  return left;
}

void Node::setLeft(Node *left) {
  this->left = left;
}

void Node::setRight(Node *right) {
  this->right = right;
}

Node* Node::getRight() {
  return right;
}

int Node::getData() {
  return data;
}

void Node::setData(int data) {
  Node::data = data;
}




