import math

total_sum = 0
for i in range(2, 1000000):
    i_str = "%s" % i
    test_sum = 0
    for digit in i_str:
        test_sum += math.pow(float(digit), 5)

    if(test_sum == i):
        total_sum += i
        print(i)

print("total: %s" % total_sum)


