import socket
import threading
import _thread as thread
import pickle

DEFAULT_HOSTNAME = '0.0.0.0'
DEFAULT_PORT = 9999

RECV_SIZE = 1024

PUT = 'p'
GET = 'g'
SHUTDOWN = 's'

class Updater(object):

    def __init__(self, serversocket, clientsocket, memo_queue, lock):
        self.serversocket = serversocket
        self.clientsocket = clientsocket
        self.memo_queue = memo_queue
        self.lock = lock


    def run(self):
        chunks = [] #TODO use a string buffer instead?
        chunk = -1
        while chunk != b"":
            #I don't think this is totally right because I think recv can
            #get a zero len answer even when the remote side has _not_
            #closed the connection
            chunk = self.clientsocket.recv(RECV_SIZE)
            #chunk = self.clientsocket.read()
            chunks.append(chunk)
        try:
            msg_parts = pickle.loads(b"".join(chunks))
        except EOFError:
            return
        
        if msg_parts[0] == PUT:
            self.update_memo_queue(msg_parts[1], msg_parts[2])
            
        elif msg_parts[0] == GET:
            self.fetch_from_memo_queue(msg_parts[1])
            
        elif msg_parts[0] == SHUTDOWN:
            self.serversocket.close()

            
        self.clientsocket.close() #TODO should shutdown?


    def update_memo_queue(self, key, value):
        #very pessimistic piece of crap to begin
        self.lock.acquire()
        if not key in self.memo_queue:
            self.memo_queue[key] = []
        self.memo_queue[key].append(value)
        self.lock.release()


    def fetch_from_memo_queue(self, key):
        self.lock.acquire()
        #TODO make this blocking?
        try:
            value = self.memo_queue[key].pop()
        except (IndexError, KeyError):
            value = None
        self.lock.release()

        pickled = pickle.dumps(value)

        self.clientsocket.send(pickled)
        

def serve(hostname=DEFAULT_HOSTNAME, port=DEFAULT_PORT, memo_queue=dict()):
    #originally from http://docs.python.org/dev/howto/sockets.html
    
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    #bind to a host and port
    serversocket.bind((hostname, port))

    #become a server socket
    serversocket.listen(5)
    
    while True:
        #accept connections from outside
        (clientsocket, address) = serversocket.accept()

        
        #hmmm
        #need some thread pool or evented server?
        #single threading this makes it faaaaast
        updater = Updater(serversocket, clientsocket, memo_queue, threading.Lock())
        #thread = threading.Thread(target=updater.run)
        #thread.start()
        updater.run()


if __name__ == '__main__':
    from optparse import OptionParser
    
    parser = OptionParser()
    parser.add_option("-p", "--port", type="int", dest="port", default=DEFAULT_PORT)
    parser.add_option("--hostname", type="string", dest="hostname", default=DEFAULT_HOSTNAME)
    (options, args) = parser.parse_args()

    memo_queue = dict()
    try:
        serve(hostname=options.hostname, port=options.port, memo_queue=memo_queue)
    except KeyboardInterrupt:
        print(memo_queue)
