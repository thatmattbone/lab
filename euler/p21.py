from euler import proper_divisors

def amicable(n):
    return sum(proper_divisors(n))


if __name__ == "__main__":
    import pprint

    amicables = {i: amicable(i) for i in range(1, 10000)}

    amicable_pairs = set()
    for n, amicable_n in amicables.iteritems():  # in example n is 220, amicable_n is 284
        if amicable_n in amicables and amicables[amicable_n] == n:
            if n < amicable_n:
                amicable_pairs.add((n, amicable_n))
            elif n > amicable_n:
                amicable_pairs.add((amicable_n, n))

    amicable_pairs = list(amicable_pairs)
    amicable_pairs.sort(key=lambda x: x[0])
    total = 0
    for x, y in amicable_pairs:
        print "{} {}".format(x, y)
        total += x
        total += y
    print total

