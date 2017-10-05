//#include <map>
//#include <utility>
//#include <string>

//const static int BASE64 = 64;
//const static int VERBATIM = 65;

using namespace std;

class Node {
public:
  Node(int data);
  virtual ~Node();

  void setLeft(Node *left);
  Node* getLeft();

  void setRight(Node *right);
  Node* getRight();

  void setData(int data);
  int getData();


private:
  Node* left; 
  Node* right;
  int data;
  //map<string, pair<int, string> > elements;
};

