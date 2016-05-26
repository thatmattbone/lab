import xml.etree.ElementTree
import random
import urllib2

#why won't this work.

#if I was a functional programmer and/or knew how to use itertools
#this could wouldn't be such a flaming piece of crap

def fetch_from_twitter(id):
    '''Return the xml or whatever the fuck format I decide to
    use of the provided twitter ID'''
    lines = urllib2.urlopen('http://twitter.com/statuses/user_timeline/%s.xml' % id).readlines() 
    return ''.join(lines)


def list_items(items=None, indent=' '):
    accum = indent + '<ul>\n'

    for item in items:
        if(type(item) == type([])):
            accum += list_items(item, indent*2)
        else:
            accum += (indent + "<li>%s</li>\n") % item

    accum += indent + '''</ul>\n'''
    return accum
        


def generate_slide(h1=None, items=None):
    accum = '''\n<div class="slide">\n'''
    
    if(h1!=None):
        accum += '''<h1>%s</h1>\n''' % h1

    accum += list_items(items)

    accum += '''</div>\n'''

    return accum




def s5_start():
  return '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>S5: An Introduction</title>
<!-- metadata -->
<meta name="generator" content="S5" />
<meta name="version" content="S5 1.1" />
<meta name="presdate" content="20050728" />
<meta name="author" content="Eric A. Meyer" />
<meta name="company" content="Complex Spiral Consulting" />
<!-- configuration parameters -->
<meta name="defaultView" content="slideshow" />
<meta name="controlVis" content="hidden" />
<!-- style sheet links -->

<link rel="stylesheet" href="static/s5/ui/default/slides.css" type="text/css" media="projection" id="slideProj" />
<link rel="stylesheet" href="static/s5/ui/default/outline.css" type="text/css" media="screen" id="outlineStyle" />
<link rel="stylesheet" href="static/s5/ui/default/print.css" type="text/css" media="print" id="slidePrint" />
<link rel="stylesheet" href="static/s5/ui/default/opera.css" type="text/css" media="projection" id="operaFix" />
<!-- embedded styles -->
<style type="text/css" media="all">
.imgcon {width: 525px; margin: 0 auto; padding: 0; text-align: center;}
#anim {width: 270px; height: 320px; position: relative; margin-top: 0.5em;}
#anim img {position: absolute; top: 42px; left: 24px;}
img#me01 {top: 0; left: 0;}
img#me02 {left: 23px;}
img#me04 {top: 44px;}
img#me05 {top: 43px;left: 36px;}
</style>
<!-- S5 JS -->
<script src="static/s5/ui/default/slides.js" type="text/javascript"></script>
</head>
<body>

<div class="layout">
<div id="controls"><!-- DO NOT EDIT --></div>
<div id="currentSlide"><!-- DO NOT EDIT --></div>
<div id="header"></div>

<div id="footer">
<h1>S5 Testbed</h1>
<h2>Your computer &#8226; Today's date</h2>
</div>
'''

def s5_end():
    return '''
</div>

</body>
</html>
'''

def stati_from_twit_feed(twitter_string):
    #tree = ElementTree()
    tree = xml.etree.ElementTree.XML(twitter_string)

    stati_tree = tree.findall('status')
    stati = list()
    
    for status in stati_tree: 
        stati.append(status.find('text').text)

    return stati

def twittle_slide(twitter_id):
    twitter_xml = fetch_from_twitter(twitter_id)
    stati = stati_from_twit_feed(twitter_xml)
    statin = len(stati)

    curr = 0
    num = random.randint(2,4)

    lines = ''

    lines += s5_start()

    while(stati[curr:curr+num] != []):

        if(curr+num > (len(stati)-1)):
            lines += generate_slide(stati[curr], stati[curr+1:])
            break

        lines += generate_slide(stati[curr], stati[curr+1:curr+num])

        curr += num
        num = random.randint(2,5)

    return lines + s5_end()

if __name__ == '__main__':
    random.seed()
    print twittle_slide('36825185')
