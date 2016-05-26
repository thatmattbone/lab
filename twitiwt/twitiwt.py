from twisted.internet import protocol, reactor
from twisted.web.client import HTTPPageGetter, HTTPClientFactory, _makeGetterFactory
import base64
from collections import defaultdict
import json
from palindrome import is_palindrome, is_palindrome_sentence, is_sarahpalindrome

class StreamingTwitter(HTTPPageGetter):
    receiving_tweets = False
    
    #TODO all this stuff below really needs to be handed off to the factory
    #in order to play nice in the reactor
    
    def lineReceived(self, line):
        #print("line: %s" % line)
        if(not self.receiving_tweets):
            if self.firstLine:
                self.firstLine = 0
                l = line.split(None, 2)
                version = l[0]
                status = l[1]
                try:
                    message = l[2]
                except IndexError:
                    # sometimes there is no message
                    message = ""
                self.handleStatus(version, status, message)
                return
            if line:
                key, val = line.split(':', 1)
                val = val.lstrip()
                self.handleHeader(key, val)
                if key.lower() == 'content-length':
                    self.length = int(val)
            else:
                self.receiving_tweets = True
                #self.handleEndHeaders()
        else:
            json_obj = json.loads(line)
            try:
                TWEET_STATS.tweeted(json_obj[u'user'][u'screen_name'], json_obj[u'text'])
            except KeyError as e:
                pass
                #print("Error: Key Error for tweet: %s" % line)
            except ValueError as e:
                pass
                #print("Error: Bad JSON for tweet: %s" % line)


class StreamingTwitterClientFactory(HTTPClientFactory):
    protocol = StreamingTwitter

    
def getTwitterStream(url, username, password, contextFactory=None, *args, **kwargs):
    encoded_auth = base64.encodestring("%s:%s" % (username, password))
    authorization_header = "Basic %s" % encoded_auth
    kwargs.update({'headers' : {'authorization': authorization_header}})
    
    return _makeGetterFactory(
        url,
        StreamingTwitterClientFactory,
        contextFactory=contextFactory,
        *args, **kwargs).deferred    
 
   
def open_streaming_handle(url):
    """Open the twitter stream in the non-twisted way.  The file-like object
    returned from this function should be used like:
    
        while(True):
            json_obj = json.loads(handle.readline())
            ...
    """
    password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
    password_mgr.add_password(None, 
                              url, 
                              TWITTER_USERNAME,
                              TWITTER_PASSWORD)
    handler = urllib2.HTTPBasicAuthHandler(password_mgr)
    opener = urllib2.build_opener(handler)
    
    return opener.open(url)
    

class PalindromeTweetStats(object):

    def __init__(self):
        self.stats = defaultdict(int)

    def tweeted(self, screen_name, tweet):
        """Called with each screen name and tweet"""
        palindrome = is_palindrome_sentence(tweet)
        if(not palindrome is False):
            print("palindrome sentence: %s" %tweet)
            return
        
        words = [word.strip() for word in tweet.split()]
        for word in words:
            palindrome = is_palindrome(word)
            if(palindrome):
                print("palindrome: %s" % palindrome)
                break
            
            palindrome = is_sarahpalindrome(word)
            if(palindrome):
                print("sarahpalindrome: %s" % palindrome)
                break


    def print_stats(self):
        """Print out the current palindrome stats"""
        reports = stats.items()
        reports.sort(key=lambda x: -1 * x[1])
        for row in reports:
            print("%s: %s" % (row[0], row[1]))
            
TWEET_STATS = PalindromeTweetStats()

if __name__ == '__main__':
    #d = getTwitterStream('http://localhost:8000', 'mbone', 'helloworld')
    from passwords import TWITTER_USERNAME, TWITTER_PASSWORD
    d = getTwitterStream('http://stream.twitter.com/1/statuses/sample.json', TWITTER_USERNAME, TWITTER_PASSWORD)
    def echo_page(page):
        reactor.stop()
    d.addCallback(echo_page)
    reactor.run()
