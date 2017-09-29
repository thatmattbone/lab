import random

class AreYouFeelingLuckyDict(dict):
    """A dictionary with a 50% chance of returning the thing you
    actually put into it."""

    exclude = set(["runs",
                   "NameError",
                   "True",
                   "random",
                   "len",
                   "list",
                   "range",
                   "sorted"])
               

    def __getitem__(self, item):

        if item in self.exclude or random.choice([True, False]):
            return dict.__getitem__(self, item)
        else:
            raise KeyError(item)

    def force(self, item):
        return dict.__getitem__(self, item)        



def bogosort(mylist):
    def sorted(is_sorted):
        prev = is_sorted[0]
        for x in is_sorted:
            if prev > x:
                return False
            prev = x
        return True

    is_sorted = []
    runs = 1
    while True:
        mutable_mylist = list(mylist)
        
        for i in range(len(mutable_mylist)):
            index = random.randint(0, len(mutable_mylist)-1)
            is_sorted.append(mutable_mylist.pop(index))

        if sorted(is_sorted):
            print(runs)
            return is_sorted
        else:
            runs+=1
            is_sorted=[]


if __name__ == "__main__":
    exec("""
a=1
b=2
while True:
  try:
    print(a)
    print(b)
    break
  except NameError:
    pass
""", AreYouFeelingLuckyDict(), AreYouFeelingLuckyDict())


    myglobals = AreYouFeelingLuckyDict(random=random)
    mylocals = AreYouFeelingLuckyDict()
    exec("""
def sorted(is_sorted):
    prev = is_sorted[0]
    for x in is_sorted:
        if prev > x:
            return False
        prev = x
    return True


mylist = [4, 1, 9, 5]
runs = 1
while True:
    try:
        is_sorted = []        
        while True:
            mutable_mylist = list(mylist)
        
            for i in range(len(mutable_mylist)):
                index = random.randint(0, len(mutable_mylist)-1)
                is_sorted.append(mutable_mylist.pop(index))

            if sorted(is_sorted):
                break
            else:
                runs+=1
                is_sorted=[]
        break
    except NameError:
        runs += 1
        pass
""", myglobals, mylocals)

    print(mylocals.force('runs'))
    print(mylocals.force('is_sorted'))


