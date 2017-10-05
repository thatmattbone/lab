import math

for a in range(1,1000):
    for b in range(1,1000):
         c2 = a*a + b*b   
         c = math.sqrt(c2)
         if (a + b + c == 1000):
             print("a:%s b%s c%s" % (a,b,c))
