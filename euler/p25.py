
def digit_count(i):
    i_str = "%s" %i
    return len(i_str)

def fib_gen():
    n_minus_one = 1
    n_minus_two = 1 
    n = 1
    while(True):
        if(n<=2):
            n+=1
            yield 1
        else:
            #print("%s+%s" %(n_minus_one, n_minus_two))
            fib = n_minus_one + n_minus_two
            n_minus_two = n_minus_one
            n_minus_one = fib
            n+=1
            yield fib
        
    

j = 1
for i in fib_gen():
    if(digit_count(i) == 1000):
        print j
        break
    j+=1
