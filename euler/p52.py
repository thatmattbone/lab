def sorted_digit_list(num):
    digit_list = []
    for digit in "%s" %num:
        digit_list.append(digit)
    digit_list.sort()
    return digit_list

x = 1
while(True):
    x2 = x * 2
    x3 = x * 3
    x4 = x * 4
    x5 = x * 5
    x6 = x * 6
    print(x)
    base = sorted_digit_list(x)
    if(sorted_digit_list(x2) == base and
       sorted_digit_list(x3) == base and
       sorted_digit_list(x4) == base and
       sorted_digit_list(x5) == base and
       sorted_digit_list(x6) == base):        
        break
    x+=1
