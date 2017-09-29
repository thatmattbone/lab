import unittest

def reverse(iterable):
    if len(iterable) == 1:
        return [iterable[0]]
    else:
        return reverse(iterable[1:]) + [iterable[0]]

def reverse2(iterable):
    reversed = []
    for i in iterable:
        reversed.insert(0, i)
    return reversed
        

def fizzbuzz():
    """Write a program that prints the numbers from 1 to 100. But for
    multiples of three print "Fizz" instead of the number and for the
    multiples of five print "Buzz". For numbers which are multiples of
    both three and five print "FizzBuzz". """

    for i in range(1, 101):
        #print i
        if i%3 == 0 and i%5 != 0:
            print "Fizz %s" % i
        elif i%5 == 0 and i%3 != 0:
            print "Buzz %s" % i
        elif i%3 == 0 and i%5 ==0:
            print "FizzBuzz %s" % i


class ReverseTest(unittest.TestCase):
    def test_reverse(self):
        self.assertEqual([1,2,3], reverse([3,2,1]))

    def test_reverse2(self):
        self.assertEqual([1,2,3], reverse2([3,2,1]))

if __name__ == "__main__":
    #unittest.main()
    fizzbuzz()
