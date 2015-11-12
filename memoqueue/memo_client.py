import socket
import pickle

from memo_server import PUT, GET, SHUTDOWN

RECV_SIZE = 1024

class MemoServer(object):
    
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.reconnect()


    def reconnect(self):
        #create an INET, STREAMing socket
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.connect((self.host, self.port))

        
    def __enter__(self):
        return self


    def put(self, key, value):
        msg_parts = (PUT, key, value)
        #TODO just stream to the socket? does that work with pickle?
        msg_parts_pickled = pickle.dumps(msg_parts)
        self.s.send(msg_parts_pickled)
        
        self.s.close()
        self.reconnect()


    def get(self, key):

        # Tell the server what we want:
        msg_parts_pickled = pickle.dumps((GET, key))
        self.s.send(msg_parts_pickled)
        self.s.shutdown(socket.SHUT_WR)

        # Wait for the response:
        chunks = [] #TODO use a string buffer instead?
        chunk = -1
        while chunk != b"":
            #I don't think this is totally right because I think recv can
            #get a zero len answer even when the remote side has _not_
            #closed the connection
            chunk = self.s.recv(RECV_SIZE)
            #chunk = self.clientsocket.read()
            chunks.append(chunk)
        try:
            value = pickle.loads(b"".join(chunks))
        except EOFError:
            return None

        self.s.close()
        self.reconnect()

        return value

    def shutdown(self):
        """Tells the remote memo queue server to shutdown."""
        msg_parts = (SHUTDOWN)
        #TODO just stream to the socket? does that work with pickle?
        msg_parts_pickled = pickle.dumps(msg_parts)
        self.s.send(msg_parts_pickled)
        
        self.s.close()        


    def __exit__(self, type, value, trace_back):
        self.s.close()


if __name__ == '__main__':

    
    with MemoServer("localhost", 9999) as memo_server:
        memo_server.put("asdf", "jkl")
        memo_server.put("qwer", "123")

        print(memo_server.get("qwer"))
        print(memo_server.get("qwer"))



