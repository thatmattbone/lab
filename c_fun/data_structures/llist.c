#include <stdio.h>
#include <stdlib.h>

//typedef struct node;

struct node {
  struct node *next;
  int data;
};

//typedef struct node node;
void print_list(struct node *list) {
  if(list->next != NULL) {
    printf("%d->", list->data);
    print_list(list->next);
  } else {
    printf("%d\n", list->data);
  }
}


struct node *reverse_list(struct node *head) {
  print_list(head);

  if(head->next == NULL) return head;

  struct node *new_tail = head;
  struct node *next = head->next;
  new_tail->next = NULL;
  
  struct node *new_head = reverse_list(next);

  next = new_head;
  while(next->next != NULL) next = next->next;

  next->next = new_tail;
  
  return new_head;
}

struct node *reverse_list2(struct node *head) {
  struct node *previous = NULL;
  struct node *next = head->next;

  while(next != NULL) {
    printf("%d", head->data);
    head->next = previous;
    head = next;
    next = head->next;
  }
  return head;
}

int main(void) {
  printf("Hello, World\n");

  struct node *mylist = malloc(sizeof(struct node));
  struct node *next = malloc(sizeof(struct node));
  struct node *nnext = malloc(sizeof(struct node));
  
  mylist->data = 5;
  next->data = 6;
  nnext->data = 7;

  mylist->next = next;
  next->next = nnext;
  nnext->next = NULL;
  
  //print_list(mylist);

  //print_list();

  next = reverse_list2(mylist);

  //print_list(next);

  return 0;
}
