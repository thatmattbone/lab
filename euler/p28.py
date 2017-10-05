from itertools import islice

def int_generator():
    i = 1
    while(True):
        yield i
        i+=1

def spiral_nums(dim):
    ints = int_generator()
    yield ints.next()
    for current_dim in range(3, dim+1, 2):
        num = 2*current_dim + 2*(current_dim-2)
        yield_me = list(islice(ints, num))
        
        offset = 1
        if(current_dim-1>0):
            offset = current_dim-1
        for i in yield_me[offset-1::offset]:
            yield i

print sum(spiral_nums(1001))
