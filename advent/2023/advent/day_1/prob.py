import os


def input_path(script_path, input_filename='input'):
    return os.path.join(os.path.dirname(script_path), input_filename)


def day_1_part_1(input_lines):
    number_lines = []
    
    for line in input_lines:
        numbers_in_the_line = [c for c in line if c.isnumeric()]
        number_lines.append(numbers_in_the_line)

    return sum([int(f'{line[0]}{line[-1]}') for line in number_lines])


def day_1_part_2(input_lines):
    replacements = [('one',   '1'),
                    ('two',   '2'),
                    ('three', '3'),
                    ('four',  '4'),
                    ('five',  '5'),
                    ('six',   '6'),
                    ('seven', '7'),
                    ('eight', '8'),
                    ('nine', '9')]

    fixed_lines = []
    for line in input_lines:
        updated_line = line
        for word, replacement in replacements:
            updated_line = updated_line.replace(word, replacement)
        fixed_lines.append(updated_line)

    return day_1_part_1(fixed_lines)


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

    print(day_1_part_2(['two1nine',
                        'eightwothree',
                        'abcone2threexyz',
                        'xtwone3four',
                        '4nineeightseven2',
                        'zoneight234',
                        '7pqrstsixteen']))
    
