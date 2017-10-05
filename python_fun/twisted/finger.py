from twisted.internet import protocol, reactor
from twisted.protocols import basic

class FingerProtocol(basic.LineReceiver):

    #def connectionMade(self):
    #    self.transport.loseConnection()

    def lineReceived(self, user):
        print_me = "You typed: %s\n" % user
        self.transport.write(print_me)
        self.transport.loseConnection()


class FingerFactory(protocol.ServerFactory):
    protocol = FingerProtocol

reactor.listenTCP(1079, FingerFactory())
reactor.run()
