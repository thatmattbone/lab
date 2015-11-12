#include <stdio.h>
#include <glib.h>
#include "core.h"
#include "reader.h"


int main(void) {

  GHashTable* symbol_table;
  symbol_table = g_hash_table_new(g_str_hash, g_str_equal);

  char *key = "hello";
  char *value = "world";

  g_hash_table_insert(symbol_table, 
                      g_strdup(key), 
                      g_strdup(value));

  char *found_value;
  found_value = (char *) g_hash_table_lookup(symbol_table, g_strdup(key));

  printf("%s\n", found_value);
  //short a;
  //printf("%d\n", sizeof(a));
  
  /*char b = read_c();
  if(separator(b)) {
    printf("separator\n");
  } else {
    printf("not a separator\n");
    }*/

}
