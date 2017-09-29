#include<stdint.h>

inline
int uComp0(void const *a, void const *b) {
  register uint64_t const *const A = a;
  register uint64_t const *const B = b;
  {
    register uint64_t const a = *A;
    register uint64_t const b = *B;
    return (a < b) ? -1 : (a > b);
  }
}

inline
int uComp1(void *a, void const *b) {  
  register uint64_t* A = a;
  register uint64_t const *const B = b;
  *A = 1;
  {
    register uint64_t const a = *A;
    register uint64_t const b = *B;
    return (a < b) ? -1 : (a > b);
  }
}

void main() {
}
