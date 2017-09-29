#IFNDEF GC_H
#DEFINE GC_H

//this is the node pool, meaning that here
//we always hold a reference to every cons cell
int Pool_size=0, Vpool_size = 0;
int *Car = NULL, *Cdr = NULL;
char *Tag = NULL;

#define SEGMENT_LEN 32768

//Garbage collection flags
#define AFLAG 0x01
#define MFLAG 0x02
#define SFLAG 0x04
#define VFLAG 0x08
//#define UFLAG 0x10 //for ports
//#define LFLAG 0x20 //for ports

void mark_vector(int n, int type);
void new_segment(void);
void mark(int n);

#ENDIF
