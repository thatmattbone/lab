/* This is simple demonstration of how to use expat. This program
   reads an XML document from standard input and writes a line with
   the name of each element to standard output indenting child
   elements by one tab stop more than their parent element.
   It must be used with Expat compiled for UTF-8 output.
*/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "expat.h"

#ifdef XML_LARGE_SIZE
#if defined(XML_USE_MSC_EXTENSIONS) && _MSC_VER < 1400
#define XML_FMT_INT_MOD "I64"
#else
#define XML_FMT_INT_MOD "ll"
#endif
#else
#define XML_FMT_INT_MOD "l"
#endif

int is_text = 0;

static void XMLCALL
startElement(void *userData, const char *name, const char **atts) {
  if(strcmp(name, "text")) {
    is_text = 0;
  } else {
    is_text = 1;
  }
}

static void XMLCALL
endElement(void *userData, const char *name) {
  if(strcmp(name, "text")) {
    is_text = 1;
  } else {
    is_text = 0;
  }
}

static void XMLCALL
characters(void *userData, const char *data, int len) {
  //printf("here");
  if(is_text)
    write(1, data, len);
}

int main(int argc, char *argv[]) {
  char buf[BUFSIZ];
  XML_Parser parser = XML_ParserCreate(NULL);
  int done;
  int depth = 0;
  XML_SetUserData(parser, &depth);
  XML_SetElementHandler(parser, startElement, endElement);
  XML_SetCharacterDataHandler(parser, characters);
  do {
    size_t len = fread(buf, 1, sizeof(buf), stdin);
    done = len < sizeof(buf);
    if (XML_Parse(parser, buf, len, done) == XML_STATUS_ERROR) {
      fprintf(stderr,
              "%s at line %" XML_FMT_INT_MOD "u\n",
              XML_ErrorString(XML_GetErrorCode(parser)),
              XML_GetCurrentLineNumber(parser));
      return 1;
    }
  } while (!done);
  XML_ParserFree(parser);
  return 0;
}
