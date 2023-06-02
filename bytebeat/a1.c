// file: a1.c
// from: https://maximullaris.com/bytebeat_gawk.html
// compile with: cc -w a1.c -o a1
// run with: ./a1 | aplay -f u8
main(t) {
  for(t=0;;t++) {
    putchar(t*((t>>12|t>>8)&63&t>>4));    
  }
}
