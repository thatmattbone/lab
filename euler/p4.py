
def reverse(mystring):
    if(mystring==""):
        return mystring
    else:
        return reverse(mystring[1:])+ mystring[0]

items = []

for x in range(100, 1000):
    for y in range(100, 1000):
        string = str(x*y)
        if(reverse(string)==string):
            items.append(x*y)
            
print max(items)
        
