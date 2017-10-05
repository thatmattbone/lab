from euler import factors
from math import sqrt

def is_prime(n):
    return len(factors(n)) == 2

prime_factors = [factor for factor in factors(600851475143) if is_prime(factor)]
prime_factors.sort()
print(prime_factors)



