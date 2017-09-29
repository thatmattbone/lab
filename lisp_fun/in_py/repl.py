from __future__ import print_function

from parse_sexp import sexp_to_tree

import sys

if __name__ == '__main__':
    while(True):
        print("=> ", end="")
        sys.stdout.flush()
        sexp = sys.stdin.readline().strip()
        print(sexp_to_tree(sexp))
