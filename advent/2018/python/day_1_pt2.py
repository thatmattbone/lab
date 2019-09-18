from itertools import cycle
from day_1_pt1 import input_as_ints

#input_as_ints = [1, -2, 3, 1]

if __name__ == '__main__':
    seen_freqs = {0}
    current_freq = 0
    
    for freq in cycle(input_as_ints):
        current_freq += freq
        
        if current_freq in seen_freqs:
            print(f'answer: {current_freq}')
            break
        else:            
            seen_freqs.add(current_freq)

        

    
