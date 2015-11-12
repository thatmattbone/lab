"""Profiling the memo server"""

from memo_client import MemoServer

def lots_of_puts():
    with MemoServer("mbone-desktop", 8889) as memo_server:
        for i in range(1, 1000):
            memo_server.put("asdf", i)

def lots_of_puts_and_gets():
    with MemoServer("mbone-desktop", 8889) as memo_server:
        for i in range(1, 1000):
            memo_server.put("asdf", i)

        for i in range(1, 1000):
            memo_server.get("asdf")

    

if __name__=='__main__':
    from timeit import Timer
    t = Timer("lots_of_puts_and_gets()", "gc.enable(); from __main__ import lots_of_puts_and_gets")
    print(t.timeit(number=1))
