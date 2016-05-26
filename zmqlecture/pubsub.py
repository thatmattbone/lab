import sys
import datetime
import time
import zmq

from util import client_server_args


def server(zmq_socket):
    context = zmq.Context()

    socket = context.socket(zmq.PUB)
    print("binding to: %s" % zmq_socket)
    socket.bind(zmq_socket)

    count = 0
    while True:
        now = str(datetime.datetime.now())

        print("send #%s" % count)
        socket.send_json({'timestamp': now,
                          'count': count})
        count += 1
        time.sleep(1)


def client(zmq_socket):
    context = zmq.Context()

    socket = context.socket(zmq.SUB)
    socket.setsockopt(zmq.SUBSCRIBE, "") #listen to all incoming messages
    socket.connect(zmq_socket)

    while True:
        json_blob = socket.recv_json()
        print json_blob


if __name__ == "__main__":
    args = client_server_args()

    if args.server:
        server(args.socket)
    elif args.client:
        client(args.socket)
