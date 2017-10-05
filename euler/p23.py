from euler import is_abundant
from itertools import combinations_with_replacement

if __name__ == "__main__":
    abundants = []
    for i in range(1, 28123 + 1):
        if is_abundant(i):
            abundants.append(i)

    print len(abundants)
    print len(set(abundants))


    combo_sums = set()
    for x, y in combinations_with_replacement(abundants, 2):
        combo_sums.add(x+y)

    import pdb; pdb.set_trace()

    answer = 0
    for i in range(1, 28123):
        if i not in combo_sums:
            answer += i

    print answer
