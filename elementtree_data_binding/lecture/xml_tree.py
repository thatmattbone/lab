from xml.etree import ElementTree
from collections import defaultdict


class DotNode(object):
    def __init__(self, element_id, element):
        self.element_id = element_id
        self.element = element

    def __str__(self):
        return """{id} [label="{label}"];""".format(id=self.element_id, label=self.element.tag)
        #return self.element_id


def get_element_id(element, element_dict):
    fixed_name = "{}_{}".format(element.tag, element_dict[element.tag])
    element_dict[element.tag] += 1
    return fixed_name


def parent_child_pairs(element, element_id, element_dict):                                          
    children = list()

    for child in element:
        child_element_id = get_element_id(child, element_dict)
        yield (DotNode(element_id, element), DotNode(child_element_id, child))
        children.append((child_element_id, child))

    for child_element_id, element in children:
        for pair in parent_child_pairs(element, child_element_id, element_dict):
            yield pair


if __name__=="__main__":

    element_counter = defaultdict(int)

    with open("expression.xml") as xml_file:
        tree = ElementTree.fromstring(xml_file.read())

        declarations = set()
        edges = []


        element_dict = defaultdict(int)
        for parent_node, child_node in parent_child_pairs(tree, get_element_id(tree, element_dict), element_dict):
            declarations.add(str(parent_node))
            declarations.add(str(child_node))            
            edges.append("{parent} -> {child};".format(parent=parent_node.element_id, child=child_node.element_id))

        print("digraph G {")
        print("\n".join(declarations))
        print("\n".join(edges))
        print("}") 
