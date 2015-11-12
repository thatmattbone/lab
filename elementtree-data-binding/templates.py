# This is a not yet working idea on how to transform 
# html (and possibly php) templates by converting them
# to trees, performing transformations, and spitting them
# back out.
#
# It is mostly useless.

import xml.etree.ElementTree as ElementTree
from xml.etree.ElementTree import XMLTreeBuilder, TreeBuilder, _ElementInterface
import sys

class BoundElement(_ElementInterface):
    def __init__(self, *args):
        _ElementInterface.__init__(self, self.tag, *args)

    def append_all(self, subelements):
        for subelement in subelements:
            if(type(subelement) == type("")):
                if(self.text == None):
                    self.text = subelement
                else:
                    self.text += subelement
            else:
                self.append(subelement)

    @classmethod
    def is_match(cls, tag, attrs=None):
        return tag == cls.tag

class DivClass(BoundElement):
    def __init__(self, *args):
        BoundElement.__init__(self, {'class':self.div_class})
        self.append_all(args)

    @classmethod
    def is_match(cls, tag, attrs=None):
        if(tag == cls.tag):
            if(attrs.has_key('class') and attrs['class'] == cls.div_class):
                return True
        return False

class MainCol(DivClass):
    tag = "div"
    div_class = "mainCol"
    
class PodTop(DivClass):
    tag = "div"
    div_class = 'podTop'

class PodBot(DivClass):
    tag = "div"
    div_class = "podBot"

class Pod(DivClass):
    tag = "div"
    div_class = "pod"

    def __init__(self, *args):
        new_args = [PodTop()]
        for arg in args:
            new_args.append(arg)
        new_args.append(PodBot())
        DivClass.__init__(self, *new_args)

class Ul(BoundElement):
    tag = "ul"
    def __init__(self, *args):
        BoundElement.__init__(self, {})
        self.append_all(args)

class Li(BoundElement):
    tag = "li"
    def __init__(self, *args):
        BoundElement.__init__(self, {})
        self.append_all(args)

class A(BoundElement):
    tag = "a"
    def __init__(self, href, *args):
        BoundElement.__init__(self, {'href':href})
        self.append_all(args)
    

outputMe = ElementTree.ElementTree(
    MainCol(
        Pod(
            Ul(
               Li("foo", A('http://foobar.com', 'bar.com')),
               Li("bar"),
               Li("baz")
              )
            )
        )
    )

outputMe.write(sys.stdout)

sys.exit()

def bound_element_factory(boundElements):
    def custom_factory(tag, attrs):
        for element in boundElements:
            if(element.is_match(tag, attrs)):
                #for this to work properly, we need to construct the objects
                #by calling a class method or something, since their
                #constructors have been modified (from the default __init__(self, tag, *attrs) 
                #to make them easier to build by hand
                #(see outputMe above)
                return element(tag, attrs)
        return _ElementInterface(tag, attrs)
    return custom_factory

element_factory = bound_element_factory([MainCol,
                                         Pod,
                                         PodTop,
                                         PodBot,
                                         Ul,
                                         Li,
                                         ])
tree = ElementTree.parse('test.xml', parser=XMLTreeBuilder(target=TreeBuilder(element_factory=element_factory)))
