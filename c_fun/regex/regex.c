/**
 * Simple regex matcher from chapter 1 of Beautiful Code by Kernighan
 * and Pike.
 * 
 * Modified slightly for some style changes and adding support for the
 * plus sign in the regex.
 */
#include <stdio.h>
#include "regex.h"


int match(char *regexp, char *text) {
  if (regexp[0] == '^') {
    return match_here(regexp+1, text);
  }

  do {
    if (match_here(regexp, text)) {
      return 1;
    }
  } while (*text++ != '\0');

  return 0;
}


int match_here(char *regexp, char *text) {
  if (regexp[0] == '\0') {
    return 1;
  }

  if (regexp[1] == '*') {
    return match_star(regexp[0], regexp+2, text);
  }

  if (regexp[1] == '+') {
    return match_plus(regexp[0], regexp+2, text);
  }

  if (regexp[0] == '$' && regexp[1] == '\0') {
    return *text == '\0';
  }

   if (*text!='\0' && (regexp[0]=='.' || regexp[0]==*text)) {
    return match_here(regexp+1, text+1);
  }
  
  return 0;
}


int match_plus(char c, char *regexp, char *text) {
  if (c != text[0]) {
    return 0;
  }
  text++;

  do {
    if (match_here(regexp, text)) {
      return 1;
    }
  } while (*text!='\0' && (*text++ == c || c == '.'));
  
  return 0;

}


int match_star(char c, char *regexp, char *text) {
  do {
    if (match_here(regexp, text)) {
      return 1;
    }
  } while (*text!='\0' && (*text++ == c || c == '.'));
  
  return 0;
}
