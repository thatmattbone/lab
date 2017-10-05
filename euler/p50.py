"""
This is wrong.
"""
from pyprimes import primes
from itertools import takewhile

MAX_PRIME = 1000000
#MAX_PRIME = 1000

if __name__ == "__main__":
    myprimes = list(takewhile(lambda x: x < MAX_PRIME, primes()))
    myprime_set = set(myprimes)
    
    print("Number of primes: {}".format(len(myprimes)))


    current_max_len = 0

    window_sizes = list(range(2, len(myprimes)))
    window_sizes.sort(reverse=True)

    for window_size in window_sizes:
        if window_size % 1000 == 0:
            print(window_size)

        if current_max_len != 0:
            break
    
        start_index = 0
        end_index = window_size

        current_list = myprimes[start_index:window_size]
        current_sum = sum(current_list)
        if current_sum in myprime_set and len(current_list) > current_max_len:
            current_max_len = len(current_list)
            current_max_list = current_list
            break
    
        start_index += 1
        end_index += 1

        while end_index < len(myprimes):
            #print("[{}:{}]".format(start_index, end_index))
            current_sum -= myprimes[start_index-1]
            current_sum += myprimes[end_index]

            if current_sum in myprime_set and window_size > current_max_len:
                current_max_len = window_size
                current_max_list = myprimes[start_index:end_index]
                break

            end_index +=1
            start_index += 1


    print(current_max_list)
    print(current_max_len)
            
