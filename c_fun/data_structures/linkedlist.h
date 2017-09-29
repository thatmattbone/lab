/** 
 * struct for singly linked list node.
 */
struct s_node {
  struct node *next;
  void *data;
};

/**
 * struct for doubly linked list node
 */
struct d_node {
  struct node *next;
  struct node *prev;
  void *data;
};
