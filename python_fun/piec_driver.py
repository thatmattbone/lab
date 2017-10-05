import sys
import marshal
from piec import hello_world

if __name__ == "__main__":
    if 'compile' in sys.argv:
        hello_world()
    else:
        f = open("piec.pyc")
        lines = f.readlines()
        print len(lines)
        print marshal.loads("".join(lines))
