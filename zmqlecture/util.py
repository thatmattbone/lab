"""
Common utilities for the zmq examples.
"""
import argparse

def client_server_args():
    parser = argparse.ArgumentParser()
    
    parser.add_argument('--client', help='Run example in client mode.', action='store_true')
    parser.add_argument('--server', help='Run example in server mode.', action='store_true')
    parser.add_argument('--socket', help='Specify zmq socket.', default="tcp://127.0.0.1:6666")

    return parser.parse_args()
