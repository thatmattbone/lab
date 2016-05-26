from xml.sax.handler import ContentHandler
from xml.sax import parse

from palindrome import palindrome_list

from collections import defaultdict

class TweetHandler(ContentHandler):

    screen_name = None
    record_screen_name = False

    tweet = None
    record_tweet = False

    def startElement(self, name, attrs):
        print(name)
        if(name == 'screen_name'):
            self.record_screen_name = True
            self.screen_name = ''
        elif(name == 'text'):
            self.record_tweet = True
            self.tweet = ''
    

    def characters(self, data):
        if(self.record_screen_name):
            self.screen_name += data
        elif(self.record_tweet):
            self.tweet += data

    def endElement(self, name):
        if(name == 'screen_name'):
            #emit tweet and restart
            self.tweeted(self.screen_name, self.tweet)

            self.reset()

        elif(name == 'text'):
            self.record_tweet = False

    def reset(self):
        self.screen_name = None
        self.record_screen_name = False
        
        self.tweet = None
        self.record_tweet = False

                

if __name__ == '__main__':
    import random
    import time
    from  xml.sax._exceptions import SAXParseException

    handle = open_streaming_handle()
    #for i in range(1, 2):
    #handle = open('public_timeline.xml')

    #try:
    handle = opener.open('http://stream.twitter.com/1/statuses/sample.xml')
    sax_handler = TweetHandler()
    while(True):
        try:
            parse(handle, sax_handler)
        except SAXParseException as e:
            print("RESET")
            sax_handler.reset()
            continue
        except:
            break
    handle.close()




