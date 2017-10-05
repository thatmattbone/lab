from itertools import permutations, islice

print list(islice(permutations(range(0,10)), 999999, 1000000))
