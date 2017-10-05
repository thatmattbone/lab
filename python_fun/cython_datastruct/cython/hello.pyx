import numpy as np
cimport numpy as np

cpdef int int_max(int a, int b): return a if a >= b else b

def say_hello_to(name):
    print("Hello %s!" % name)