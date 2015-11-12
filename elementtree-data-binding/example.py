import xml.etree.ElementTree as ElementTree
from xml.etree.ElementTree import XMLTreeBuilder, TreeBuilder, _ElementInterface

class Twitter(_ElementInterface):
    """Twitter base class, this is explicitly bound to the <statuses>
    tag (the root of the document).
    """
    def get_tweets(self):
        return self.findall('status/text')


class Tweet(_ElementInterface):
    """Tweet class, this is bound to <text> elements.  There are many
    instances, one for each tweet in the feed."""
    word_count = None
    word_list = None

    def __init__(self, tag, attrs):
        _ElementInterface.__init__(self, tag, attrs)
        #cannot reference self.text inside here because we have not
        #yet seen it.
        #the text is appended to the element after it is constructed.

    def word_count(self):
        return len(self.text.split())

    def at_someone(self):
        for word in self.text.split():
            if(word.startswith('@')):
                return True
        return False
        

def bound_element_factory(tag, attrs):
    if(tag == 'text'):
        return Tweet(tag, attrs)
    elif(tag == 'statuses'):
        return Twitter(tag, attrs)
    else:
        return _ElementInterface(tag, attrs)

parser = XMLTreeBuilder(target=TreeBuilder(element_factory=bound_element_factory))
tree = ElementTree.parse('mytweets.xml', parser=parser)


tweets = tree.getroot().get_tweets()
tweet_count = 0
tweet_at_count = 0
word_count = 0

for tweet in tweets:
    tweet_count += 1
    word_count += tweet.word_count()
    if(tweet.at_someone()):
        tweet_at_count += 1

print("You had %s tweets for a total of %s words." % (tweet_count, word_count))
print("%s of your tweets were at someone." % (tweet_at_count))    

