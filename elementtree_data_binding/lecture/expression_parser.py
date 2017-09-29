import json
import unittest
from xml.etree import ElementTree

class IntegerNode(object):
    def __init__(self, value):
        self.value = value


class SubtractionNode(object):
    def __init__(self, children):
        self.children = children

    @property
    def value(self):
        init = None
        for child in self.children:
            if init is None:
                init = child.value
            else:
                init -= child.value
        return init


class AdditionNode(object):
    def __init__(self, children):
        self.children = children

    @property
    def value(self):
        init = 0
        for child in self.children:
            init += child.value
        return init


class MultiplicationNode(object):
    def __init__(self, children):
        self.children = children

    @property
    def value(self):
        init = 1
        for child in self.children:
            init *= child.value
        return init


def parse_json(blob):
    def _parse_dict(expression):
        if isinstance(expression, dict) and expression["operation"] == "subtract":
            return SubtractionNode([_parse_dict(child) for child in expression["children"]])
        elif isinstance(expression, dict) and expression["operation"] == "add":
            return AdditionNode([_parse_dict(child) for child in expression["children"]])
        elif isinstance(expression, dict) and expression["operation"] == "multiply":
            return MultiplicationNode([_parse_dict(child) for child in expression["children"]])
        else:
            return IntegerNode(int(expression))
        
    return _parse_dict(json.loads(blob))


def parse_sexpresion(blob):
    pass


def parse_xml(blob):
    element_tree = ElementTree.fromstring(blob)
    def _parse_xml(node):
        if node.tag == "expression":
            return _parse_xml(list(node)[0])
        elif node.tag == "add":
            return AdditionNode([_parse_xml(child) for child in node])
        elif node.tag == "subtract":
            return SubtractionNode([_parse_xml(child) for child in node])
        elif node.tag == "multiply":
            return MultiplicationNode([_parse_xml(child) for child in node])
        elif node.tag == "integer":
            return IntegerNode(int(node.attrib["value"]))
    return _parse_xml(element_tree)


class ExpressionParserTest(unittest.TestCase):

    def test_int_node(self):
        self.assertEqual(40, IntegerNode(40).value)
    

    def test_mult_node(self):
        self.assertEqual(40, MultiplicationNode([IntegerNode(2), IntegerNode(20)]).value)


    def test_sub_node(self):
        self.assertEqual(8, SubtractionNode([IntegerNode(10), IntegerNode(2)]).value)


    def test_add_node(self):
        self.assertEqual(12, AdditionNode([IntegerNode(10), IntegerNode(2)]).value)


    def test_expression_tree(self):
        tree = SubtractionNode([AdditionNode([IntegerNode(3), MultiplicationNode([IntegerNode(2), IntegerNode(20)])]), IntegerNode(1)])
        self.assertEqual(42, tree.value)


    def test_parse_json(self):
        with open("expression.json") as json_file:
            json_blob = json_file.read()
            tree = parse_json(json_blob)
            self.assertEqual(42, tree.value)

    def test_parse_xml(self):
        with open("expression.xml") as xml_file:
            xml_blob = xml_file.read()
            tree = parse_xml(xml_blob)
            self.assertEqual(42, tree.value)

if __name__ == "__main__":
    unittest.main()
