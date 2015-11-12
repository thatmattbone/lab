"""
A bloom filter server.
"""

from twisted.internet import protocol, reactor

class Echo(protocol.Protocol):
    def dataReceived(self, data):
        self.transport.write(data)

class EchoFactory(protocol.Factory):
    def buildProtocol(self, addr):
        print addr
        return Echo()

if __name__ == "__main__":
    reactor.listenTCP(1234, EchoFactory())
    reactor.run()
