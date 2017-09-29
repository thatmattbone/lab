#IFNDEF S9_H
#DEFINE S9_H

//special values
#define special_value_p(x) ((x)<0)
#define NIL (-1)
#define TRUE (-2)
#define FALSE (-3)
#define ENDOFFILE (-4)
#define UNDEFINED (-5)
#define UNSPECIFIC (-6)
#define DOT (-7)
#define RPAREN (-8)
#define NOEXPR (-9)

int Level = 0;
int Error_flag = 0;
int Load_level = 0;
int Displaying = 0;
int Queiet_mode = 0;

void print(int n);
#define read_c() getc(stdin)
#define read_c_ci() tolower(read_c())
int read_form(void);

#ENDIF
