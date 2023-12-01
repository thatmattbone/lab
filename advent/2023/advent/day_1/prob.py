import os
import re


def input_path(script_path, input_filename='input'):
    return os.path.join(os.path.dirname(script_path), input_filename)


def day_1_part_1(input_lines):
    number_lines = []
    
    for line in input_lines:
        numbers_in_the_line = [c for c in line if c.isnumeric()]
        number_lines.append(numbers_in_the_line)

    return sum([int(f'{line[0]}{line[-1]}') for line in number_lines])


WORDS = {'one': '1',
         'two': '2',
         'three': '3',
         'four': '4',
         'five': '5',
         'six': '6',
         'seven': '7',
         'eight': '8',
         'nine': '9'}


def fix_line(line: str) -> str:
    matches = []
    for word in WORDS.keys():
        re_matches = list(re.finditer(word, line))

        if len(re_matches) >= 0:        
            matches.extend([(word, m.start()) for m in re_matches])

    if len(matches) == 0:
        return line
    else:
        matches.sort(key=lambda x: x[1])

        line_list = list(line)
        for i, (word, location) in enumerate(matches):
            line_list.insert(i + location, WORDS[word])
            
        
        return ''.join(line_list)
        

    
def day_1_part_2(input_lines):
    # print([fix_line(line) for line in input_lines])
    return day_1_part_1([fix_line(line) for line in input_lines])


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
    print(day_1_part_2(['tdmjfourfour8fiveseveneight']))
    print(day_1_part_2(input_lines))
    
