def prime():
    '''Yields the sequence of prime numbers via the Sieve of Eratosthenes.'''
    D = {}  # map composite integers to primes witnessing their compositeness
    q = 2   # first integer to test for primality
    while 1:
        if q not in D:
            yield q        # not marked composite, must be prime
            D[q*q] = [q]   # first multiple of q not already marked
        else:
            for p in D[q]: # move each witness to its next multiple
                D.setdefault(p+q,[]).append(p)
            del D[q]       # no longer need D[q], free memory
        q += 1

def is_pandigital(x):
    x_str = '%s' % x
    pan_digits = {} 
    
    if(len(x_str) > 9): return False
    
    for i in range(1, len(x_str)+1):
        pan_digits['%s' % i] = 0
        
    for char in x_str:
        if(char == '0'): return False
        if(pan_digits.has_key(char)):
            pan_digits[char] += 1
        else:
            return False
    for value in pan_digits.values():
        if(value != 1):
            return False
    return True


p = prime()
i=0
while(i<987654321):
    i = p.next()
    if(is_pandigital(i)):
        print i
