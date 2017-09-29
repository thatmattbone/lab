#include <stdio.h>
#include <glib.h>
#include "regex.h"

#define is_match(regexp, text)    g_assert(match(regexp, text));
#define is_not_match(regexp, text)    g_assert(!match(regexp, text));


void test_straight_match() {
  is_match("fuck", "fuck");
}


void test_dot_match() {
  is_match("fu.k", "fuck");
  is_match("fu.k", "fukk");
}


void test_end_of_line() {
  is_match("^fu.k$", "fukk");
  is_not_match("^fu.k$", "fucka");
}


void test_start_of_line() {
  is_match("^fu.k", "fucka");
}


void test_star() {
  char* hello_world = "hello *world";
  is_match(hello_world, "hello world");
  is_match(hello_world, "helloworld");
}



void test_plus() {
  char* hello_world = "hello +world";
  is_match(hello_world, "hello world");
  is_match(hello_world, "hello  world");
  is_not_match(hello_world, "helloworld");
}


int main(int argc, char *argv[]) {
  g_test_init(&argc, &argv, NULL);

  g_test_add_func("/regex/straight_match", test_straight_match);
  g_test_add_func("/regex/dot_match", test_dot_match);
  g_test_add_func("/regex/end_of_line", test_end_of_line);
  g_test_add_func("/regex/start_of_line", test_start_of_line);
  g_test_add_func("/regex/star", test_star);
  g_test_add_func("/regex/plus", test_plus);

  return g_test_run();
}
