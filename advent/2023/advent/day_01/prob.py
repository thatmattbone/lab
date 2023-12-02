import re
from typing import List

from advent.util import input_path


WORDS = {'one': '1',
         'two': '2',
         'three': '3',
         'four': '4',
         'five': '5',
         'six': '6',
         'seven': '7',
         'eight': '8',
         'nine': '9'}


def day_1_part_1(input_lines: List[str]) -> int:
    number_lines = []
    
    for line in input_lines:
        numbers_in_the_line = [c for c in line if c.isnumeric()]
        number_lines.append(numbers_in_the_line)

    return sum([int(f'{line[0]}{line[-1]}') for line in number_lines])


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
        

    
def day_1_part_2(input_lines: List[str], debug: bool = False) -> int:
    fixed_lines = [fix_line(line) for line in input_lines]
    if debug:
        for line, fixed_line in zip(input_lines, fixed_lines):
            print(f'{line} -- {fixed_line}')
    return day_1_part_1([fix_line(line) for line in input_lines])


if __name__ == '__main__':
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
                        '7pqrstsixteen'], debug=True))
    print(day_1_part_2(['tdmjfourfour8fiveseveneight'], debug=True))
    print(day_1_part_2(input_lines))
