

def long_division(n):
    current = 10 
    while current != 0:
        temp = current / n        
        yield temp
        current = (current - (temp * n))*10


if __name__ == "__main__":
    
    division_map = {}
    
    for i in range(1, 1001):

        current_value_string = ""
        for value in long_division(i):
            print current_value_string
            found = False
            current_value_string += str(value)
            
            for j in range(1, len(current_value_string)+1):
                if current_value_string[1:j]*3 == current_value_string:
                    found = True
                    current_value_string = current_value_string[1:j]
            
            if found:
                break

        division_map[i] = current_value_string
    print division_map[i]
