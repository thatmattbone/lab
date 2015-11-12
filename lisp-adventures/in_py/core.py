

class cell(object):

    def __init__(self, car=None, cdr=None):
        self.car = car
        self.cdr = cdr

    def cons(self, cell):
        self.cdr = cell

class data_cell(cell):
    """Cons cells that hold data only.

    They print and evaluate to themselves."""

    def __unicode__(self):
        return "%s" % self.car

class str_cell(data_cell):
    pass

class int_cell(data_cell):
    pass

def pprint(cell):
    pass

def eval(cell):

    if(isinstance(cell, int_cell)):
        #integer cells evaluate to themselves
        return cell

    
    else:
        return None
