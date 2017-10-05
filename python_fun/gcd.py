def gcd(a, b):
    print("%s, %s" % (a, b))
    if b == 0:
        return a
    else:
        return gcd(b, a % b)


