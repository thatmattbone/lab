#include <stdio.h>
#include <glib.h>
#include "linkedlist.h"


void test_simple_single() {
  int first_data = 1;
  int second_data = 2;
  
  struct s_node first, second;

  first.data = &first_data;
  second.data = &second_data;

  g_assert_cmpint(1, ==, 1);
  g_assert_cmpint(1, ==, *((int*) first.data));
  g_assert_cmpint(2, ==, *((int*) second.data));
  g_assert_cmpint(2, ==, *((int*) second.next.data));
}


int main(int argc, char *argv[]) {
  g_test_init(&argc, &argv, NULL);

  g_test_add_func("/linkedlist/test_simple_single", test_simple_single);

  return g_test_run();
}
