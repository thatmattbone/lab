from twisted.web.client import getPage
from twisted.internet import reactor

def errorHandler(page):
    print 'error\n'
    print page

    reactor.stop()

def successHandler(page):
    print 'victory!\n'
    print page

    reactor.stop()

deferred = getPage('http://couponcabin.com')

deferred.addCallback(successHandler)
deferred.addErrback(errorHandler)

reactor.run()
