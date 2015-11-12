import unittest
import socket
import threading

from memo_server import serve
from memo_client import MemoServer
import time

def thread_a_server():
    """Start a memo server locally (in a thread) and return a
    tuple: (hostname, port, underlying_dict)
    """
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    #fix this:
    hostname = socket.gethostname()

    port = 8886
    memo_queue = dict()

    thread = threading.Thread(target=lambda: serve(port, memo_queue))
    thread.start()

    return (hostname, port, memo_queue)


#make these not-module level globals when there's good way to
#stop and join() a server thread


class FunctionalTests(unittest.TestCase):
    """Functional tests for the memo client and server.
    """

    def setUp(self):
        self.hostname, self.port, self.memo_queue = thread_a_server()
        time.sleep(1)


    def tearDown(self):
        with MemoServer(self.hostname, self.port) as memo_server:
            memo_server.shutdown()


    # def test_put(self):
    #     with MemoServer(self.hostname, self.port) as memo_server:
    #         memo_server.put("asdf", "jkl")
    #         memo_server.put("asdf", "qwer")

    #         memo_server.put("qwer", "123")
            
            
    #     self.assertEquals(["jkl", "qwer"], self.memo_queue["asdf"])
    #     self.assertEquals(["123"], self.memo_queue["qwer"])


    def test_get(self):
        self.memo_queue["123"] = ["a", "b"]
        with MemoServer(self.hostname, self.port) as memo_server:
            get1 = memo_server.get("123")
            get2 = memo_server.get("123")
            get3 = memo_server.get("123")

            get4 = memo_server.get("456")

            self.assertEquals("b", get1)
            self.assertEquals("a", get2)
            self.assertEquals(None, get3)
            self.assertEquals(None, get4)
            

        
if __name__ == '__main__':
    unittest.main()
