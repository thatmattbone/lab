import xml.etree.ElementTree 

exampleXml = """
<impls>
  <cpython>
    <versions>
      <version>2.7</version>
      <version stable="yes">3.2</version>    
      <version stable="no">3.3</version>
    </versions>
  </cpython>
  <jython>
    <versions>
      <version>2.5</version>
    </versions>
  </jython>
</impls>
"""

tree = xml.etree.ElementTree.fromstring(exampleXml)

a = tree.findall("cpython//") # Finds all subelements of cpython
print(a)
print("*"*80)


a = tree.findall("*//version") # Finds all occurences of version tags
print(a)
print("*"*80)

a = tree.findall("cpython/*/version") # Finds all occurences of version tags that are grandchildren of cpython
print(a)
print("*"*80)

a = tree.findall("cpython/versions/version[1]") # Finds the second occurence of version tag under cpython
print (a)
print("*"*80)

a = tree.findall("*//version[@stable]") # Finds all occurrences of version tags with stable attributes
print(a)
print("*"*80)

a = tree.findall("*//version[@stable='yes']") # Finds all occurrences of version tags with stable attributes with values of yes
print(a)

