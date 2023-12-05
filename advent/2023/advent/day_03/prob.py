import re
from typing import List, Tuple
from collections import defaultdict

from advent.util import input_path, input_lines

InputType = List[str]


def build_input_type(lines: List[str]) -> InputType:
    return lines

def get_indices_to_check(row: int, start: int, end: int) -> List[Tuple[int, int]]:
    indices_to_check = [(row, start - 1), (row, end)]
    indices_to_check.extend([(row - 1, i) for i in range(start - 1, end + 1)])
    indices_to_check.extend([(row + 1, i) for i in range(start - 1, end + 1)])

    return indices_to_check
    

def is_part_number(list_of_points: List[Tuple[int, int]], input: InputType) -> bool:
    input_max = len(input)
    
    for row, column in list_of_points:
        if row < 0:
            continue
        if row > input_max - 1:
            continue
        if column < 0:
            continue
        if column > input_max - 1:
            continue

        if input[row][column] != '.' and not input[row][column].isnumeric():
            return True
    
    return False


def day_03_part_1(input: InputType, debug: bool = False) -> int:
    part_numbers = []
    
    for row, line in enumerate(input):
        matches = list(re.finditer('\d+', line))

        for match in matches:
            num = int(match.group())

            indices_to_check = get_indices_to_check(row, match.start(), match.end())
                                    
            if is_part_number(indices_to_check, input):
                part_numbers.append(num)

        if debug:
            print(part_numbers)

    return sum(part_numbers)


def find_adjacent_asterisks(list_of_points: List[Tuple[int, int]], input: InputType) -> List[Tuple[int, int]]:
    input_max = len(input)

    asterisks = []
    
    for row, column in list_of_points:
        if row < 0:
            continue
        if row > input_max - 1:
            continue
        if column < 0:
            continue
        if column > input_max - 1:
            continue

        if input[row][column] == '*':
            asterisks.append((row, column))
    
    return asterisks


def day_03_part_2(input: InputType, debug: bool = False) -> int:
    possible_gear_ratios = defaultdict(list)
    
    for row, line in enumerate(input):
        matches = list(re.finditer('\d+', line))

        for match in matches:
            num = int(match.group())

            indices_to_check = get_indices_to_check(row, match.start(), match.end())
            
            for ratio in find_adjacent_asterisks(indices_to_check, input):
                possible_gear_ratios[ratio].append(num)
                

        if debug:
            print(possible_gear_ratios)

    answer = 0
    for ratio_list in possible_gear_ratios.values():
        if len(ratio_list) == 2:
            answer += ratio_list[0] * ratio_list[1]
        elif len(ratio_list) > 2:
            print(ratio_list)

    return answer


if __name__ == '__main__':
    input_list = input_lines(__file__)
    input = build_input_type(input_list)

    test_input = """\
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..""".split('\n')

    print(day_03_part_2(test_input, debug=True))
    
    print(day_03_part_1(input))
    print(day_03_part_2(input))
