
def growth_rate(starting_value, percent):
    working_value = float(starting_value)
    fixed_percent = percent + 1.0
    i = 0
    while True:
        working_value *= fixed_percent
        i += 1
        yield i, working_value/starting_value, working_value
    
