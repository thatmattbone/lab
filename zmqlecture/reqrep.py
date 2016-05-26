import zmq

from util import client_server_args


def client(zmq_socket):
    context = zmq.Context()

    socket = context.socket(zmq.REQ)
    socket.connect(zmq_socket)

    f = 39.6
    print("Farenheit: %f" % f)
    socket.send(str(f))
    c_str = socket.recv()
    c = float(c_str)

    print("Celsius: %d" % c)


def server(zmq_socket):
    context = zmq.Context()

    socket = context.socket(zmq.REP)
    print("binding to: %s" % zmq_socket)
    socket.bind(zmq_socket)

    while True:
        f = float(socket.recv())
        print("recv: %f" % f)
        c = (f - 32.0) * 5.0/9.0
        socket.send(str(c))

    
if __name__ == "__main__":
    args = client_server_args()

    if args.server:
        server(args.socket)
    elif args.client:
        client(args.socket)
