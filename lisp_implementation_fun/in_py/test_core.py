import unittest2 as unittest

from core import *

class TestCell(unittest.TestCase):

    def test_cons(self):
        cons = cell()
        self.assertTrue(cons.car is None)
        self.assertTrue(cons.cdr is None)
        
        cons2 = cell()

        cons.cons(cons2)
        
        self.assertTrue(cons.car is None)
        self.assertTrue(cons.cdr is cons2)
        

    def test_int_cell(self):
        five = int_cell(5)

        self.assertEquals(5, five.car)
        self.assertTrue(five.cdr is None)


class TestEval(unittest.TestCase):

    def test_int_cell_eval(self):

        five = int_cell(5)

        return_cell = eval(five)

        self.assertTrue(return_cell is five)
        


if __name__ == '__main__':
    unittest.main()
