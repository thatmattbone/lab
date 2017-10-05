import zope.component
from zope.interface import Interface, implements
from zope.interface.verify import verifyClass
from zope.component.factory import Factory
from zope.component import createObject
from zope.component.interfaces import IFactory

class IMessageBuilder(Interface):

    def build_message():
        """Build a message."""


class SpecialMessageBuilder(object):
    implements(IMessageBuilder)

    def build_message(self):
        return """I'm a special message."""


class DailyMessageBuilder:
    implements(IMessageBuilder)

    def build_message(self):
        return """I'm a daily message."""


if __name__ == "__main__":
    gsm = zope.component.getGlobalSiteManager()

    verifyClass(IMessageBuilder, DailyMessageBuilder)

    s = SpecialMessageBuilder()
    d = DailyMessageBuilder()

    # sf = Factory(SpecialMessageBuilder)
    df = Factory(DailyMessageBuilder)
    df()

    # #print sf()
    #gsm.registerUtility(sf, IFactory, 'spec')
    gsm.registerUtility(df, IFactory, 'daly')

    print list(gsm.registeredUtilities())
    #print dir(gsm)
    
    
    # print createObject('spec')
    print createObject('daly')
    
