def is_even(n):
    return n % 2 == 0

def next_num(n):
    if(is_even(n)):
        return n/2
    else:
        return 3*n + 1

nums = dict()

def seq_len(n):
    orig = n
    if(nums.has_key(n)):
        return nums[n]
    i = 1
    #print n
    while(n!=1):
        n = next_num(n)
        if(nums.has_key(n)):
            i+=nums[n]
            #print "here"
            break
        #print n
        i += 1
    nums[orig] = i
    return i
print seq_len(16) #5        
print seq_len(4) #3        
print seq_len(40) #9
print seq_len(13) #10


max = 0
n = 0
for i in range(1, 1000001):
    len = seq_len(i)
    if(len>max):
        max = len
        n = i
        print i

print max
print n
