import sys
import zmq


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: sub.py <zmq_sub_socket> <zmq_pull_socket>")
        sys.exit(1)
    zmq_sub_socket = sys.argv[1]
    zmq_pull_socket = sys.argv[2]
        
    context = zmq.Context()

    sub = context.socket(zmq.SUB)
    sub.setsockopt(zmq.SUBSCRIBE, "") #listen to all incoming messages
    sub.connect(zmq_sub_socket)
    
    pull = context.socket(zmq.PULL)
    pull.connect(zmq_pull_socket)


    poller = zmq.Poller()
    poller.register(sub)
    poller.register(pull)

    while True:
        revents = poller.poll(timeout=100) 

        for socket, count in revents:                
            if socket == sub:
                for i in range(count):
                    json_blob = sub.recv_json()
                    print "SUB: %s" % json_blob

            elif socket == pull:
                for i in range(count):
                    json_blob = pull.recv_json()
                    print "PULL: %s" % json_blob
