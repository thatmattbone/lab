"""
redis-in-py server
"""

from twisted.internet import protocol, reactor
from twisted.protocols.basic import LineReceiver

from backend import Backend
from response import BaseResponse


def coerce_arg(arg):
    try:
        arg = int(arg)
    except ValueError:
        pass
    return arg


class RedisCommandReceiver(LineReceiver):
    """
    Protocol for redis.

    Produces a call to redisCommandReceived (commands come as multiple
    lines) with all arguments the right size and type.
    """

    pending_command = None
    pending_arg_len = None
    

    def redisCommandReceived(self, command, args):
        raise NotImplementedError


    def sendStatusReply(self, status=b'OK'):
        """
        Send a status reploy to the client.

        From http://redis.io/topics/protocol:
          In a Status Reply the first byte of the reply is "+"

        :param status: status msg encodes as `bytes`
        """
        self.sendLine(b"+" + status)


    def sendErrorReply(self, error):
        """
        Send an error reply to the client.

        From http://redis.io/topics/protocol:
          In an Error Reply the first byte of the reply is "-"

        :param error: error msg encoded as `bytes`
        """
        self.sendLine(b"-" + error)


    def sendIntegerReply(self, value):
        """
        Send an integer reply to the client.

        From http://redis.io/topics/protocol:
          In an Integer Reply the first byte of the reply is ":"

        :param value: integer encodes as `bytes`
        """
        self.sendLine(b":" + value)


    def _responsesForValue(self, value):
        if value is None:
            return [b'$-1']
        else:
            return [b'$' + str(len(value)).encode(), value]
        

    def sendBulkReply(self, value):
        """
        Send a bulk reply to the client. Strings are all sent as bulk replies.

        From http://redis.io/topics/protocol:
          In a Bulk Reply the first byte of the reply is "$"

        :param value: a value encoded as `bytes`
        """
        for response in self._responsesForValue(value):
            self.sendLine(response)


    def sendMultiBulkReply(self, values):
        """
        Send a multi-bulk reply to the client. Lists are all sent as multi-bulk replies

        From http://redis.io/topics/protocol:
          In a Multi Bulk Reply the first byte of the reply s "*"
        """
        self.sendLine(b"*" + str(len(values)).encode())
        for value in values:
            for response in self._responsesForValue(value):
                self.sendLine(response)


    def lineReceived(self, line):
        # TODO this is pretty naive, could be improved greatly

        if line.startswith(b'*') and len(line) > 1:
            # new command
            if self.pending_command is not None:
                self.transport.disconnect()  # got a command when we were expecting args

            self.pending_command = {
                'expected_len': int(line[1:]),
                'args': []
            }

        elif line.startswith(b'$'):
            # new arg coming
            if self.pending_arg_len is not None:
                self.transport.disconnect()  # got a an arg len specifier when we were expecting an arg

            self.pending_arg_len = int(line[1:])
        
        else:
            # processing an arg
            assert len(line) == self.pending_arg_len

            self.pending_command['args'].append(line)
            self.pending_arg_len = None

            
        if (self.pending_arg_len is None and len(self.pending_command['args']) == self.pending_command['expected_len']):
            # check to see if we have all our args
            args = [arg.decode() for arg in self.pending_command['args']]
            self.pending_command = None
            self.redisCommandReceived(args[0].lower(), 
                                      [coerce_arg(arg) for arg in args[1:]])


class RedisInPy(RedisCommandReceiver):
    def __init__(self, backend, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.backend = backend

    def redisCommandReceived(self, command, args):
        print("*" * 10)
        print("{}: {}".format(command, args))
        result = self.backend.dispatch(command, args)

        print("result: {}".format(result))

        if result is None:
            self.sendStatusReply()
        elif isinstance(result, str):
            self.sendBulkReply(result.encode())
        elif isinstance(result, int):
            self.sendIntegerReply(str(result).encode())
        elif isinstance(result, list):
            self.sendMultiBulkReply([str(value).encode() for value in result])
        elif isinstance(result, BaseResponse):
            for line in result.response_lines():
                self.sendLine(line)
        else:
            raise Exception("Unknown response: " + result)


class RedisInPyFactory(protocol.Factory):
    backend = Backend()

    def buildProtocol(self, addr):
        return RedisInPy(self.backend)


if __name__ == "__main__":
    reactor.listenTCP(1234, RedisInPyFactory())
    reactor.run()
