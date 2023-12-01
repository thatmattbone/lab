import os


def input_path(script_path, input_filename='input'):
    return os.path.join(os.path.dirname(script_path), input_filename)


def day_1_part_1(input_lines):
    number_lines = []
    
    for line in input_lines:
        numbers_in_the_line = [c for c in line if c.isnumeric()]
        number_lines.append(numbers_in_the_line)

    return sum([int(f'{line[0]}{line[-1]}') for line in number_lines])


if __name__ == '__main__':
    input_lines = []
    with open(input_path(__file__)) as lines:
        for line in lines:
            input_lines.append(line.strip())

    print(day_1_part_1(['1abc2',
                        'pqr3stu8vwx',
                        'a1b2c3d4e5f',
                        'treb7uchet']))
    print(day_1_part_1(input_lines))
    
