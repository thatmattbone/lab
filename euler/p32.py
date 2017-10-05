

def is_pandigital(x, y, z):
    pan_digits = {'1':0,
                  '2':0,
                  '3':0,
                  '4':0,
                  '5':0,
                  '6':0,
                  '7':0,
                  '8':0,
                  '9':0}
    digi_str = '%s%s%s' % (x, y, z)
    if(len(digi_str) != 9): return False
    for char in digi_str:
        if(char == '0'): return False
        pan_digits[char] += 1
    for value in pan_digits.values():
        if(value != 1):
            return False
    return True

print(is_pandigital(39, 186, 7254))
print(is_pandigital(39, 186, 7253))

seen_it = dict()


top = 5000 
pan_set = []
for i in range(1, top):
    for j in range(1, top):
        x = i
        y = j
        #if(seen_it.has_key('%s.%s' %(x,y)) or
        #   seen_it.has_key('%s.%s' %(y,x))):
        #    continue
        z = x*y
        #seen_it['%s.%s' %(x,y)] = 1
        if(is_pandigital(x,y,z)):
            pan_set.append(z)
            print("%s * %s = %s" % (x, y, z))
print sum(set(pan_set))

