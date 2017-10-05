from math import sqrt


class memoize(object):

    def __init__(self, function):
        self.function = function
        self.memoized = {}

    def __call__(self, *args):
        try:
            return self.memoized[args]
        except KeyError:
            self.memoized[args] = self.function(*args)
            return self.memoized[args]


@memoize
def factors(n):
    fact = [1, n]
    check = 2
    rootn = sqrt(n)
    while check < rootn:
        if n % check == 0:
            fact.append(check)
            fact.append(n / check)
        check += 1
    if rootn == check:
        fact.append(check)
        fact.sort()
    return fact


def proper_divisors(n):
    """
    Proper Divsisors of 28:
    1, 2, 4, 7, 14
    """
    return [i for i in range(1, n) if n % i == 0]


def is_perfect(n):
    """
    A perfect number is a number for which the sum of its proper
    divisors is exactly equal to the number.
    """
    return sum(proper_divisors(n)) == n


def is_abundant(n):
    """
    A number n is called abundant if the sum of its proper divisors is
    greater than n.
    """
    return sum(proper_divisors(n)) > n
