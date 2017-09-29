#include <stdlib.h>
#include "gc.h"

void new_segment(void) {
  //creating a new segment, i.e. we needs more memory
  Car = realloc(car, sizeof(int)*(Pool_size+SEGMENT_LEN));
  Cdr = realloc(car, sizeof(int)*(Pool_size+SEGMENT_LEN));
  Tag = realloc(car, Pool_size+SEGMENT_LEN); //*sizeof char? safer?
  Vectors = realloc(Vectors, sizeof(int) * (Vpool_size + SEGMENT_LEN));
  
  if(Car==NULL || Cdr==NULL || Tag==NULL || Vectors==NULL) {
    fatal("out of memory");
  }

  memset(&Car[Pool_size], 0, SEGMENT_LEN*sizeof(int));
  memset(&Cdr[Pool_size], 0, SEGMENT_LEN*sizeof(int));
  memset(&Tag[Pool_size], 0, SEGMENT_LEN);
  memset(&Vectors[Pool_size], 0, SEGMENT_LEN*sizeof(int));

  Pool_size += SEGMENT_LEN;
  Vpool_size += SEGMENT_LEN;
}

void mark_vector(int n, int type) {
  int *p, k;
  p = &Vectors[Cdr[n] - 2];
  *p = n;
  if(type==S_vector) {
    k = vector_len(n);
    p = vector(n);
    while(k) {
      mark(*p);
      p++;
      k--;
    }
  }
}

void mark(int n) {
  int p, parent;

  parent = NIL;

  while(1) {
    if(special_value_p(n) || Tag[n] & MFLAG) {
      if(parent==NIL) break;

      if(Tag[parent] & SFLAG) {
	p = Cdr[parent];
	Cdr[parent] = n;
	Tag[parent] &= ~SFLAG;
	Tag[parent] |= MFLAG;
	n = p;
      } else {
	p = parent;
	parent = Cdr[p];
	Cdr[p] = n;
	n = p;
      }
    } else {
      if(Tag[n] & VFLAG) {
	Tag[n] |= MFLAG;
	mark_vector(n, Car[n]);
      } else if(Tag[n] & AFLAG) {
	p = Cdr[n];
	Cdr[n] = parent;
	parent = n;
	n = p;
	Tag[parent] |= MFLAG;
      } else {
	p = Car[n];
	Car[n] = parent;
	Tag[n] |= MFLAG;
	parent = n;
	n = p;
	Tag[parent] |= SFLAG;
      }
    }
  }
}

#define save(n) (Stack = alloc((n), Stack))

int unsave(int k) {
  int n = NIL;
  
  while(k) {
    if (Stack == NIL) fatal("unsave(): stack underflow\n");
    n = Car[Stack];
    Stack = Cdr[Stack];
    k = k-1;
  }
  return n;
}
