import re
from typing import List, Tuple

from advent.util import input_path, input_lines

InputType = List[str]


def build_input_type(lines: List[str]) -> InputType:
    return lines


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

            start = match.start()
            end = match.end()

            indices_to_check = [(row, start - 1), (row, end)]
            indices_to_check.extend([(row - 1, i) for i in range(start - 1, end + 1)])
            indices_to_check.extend([(row + 1, i) for i in range(start - 1, end + 1)])

            #if num == 617:
            #    breakpoint()
                                    
            if is_part_number(indices_to_check, input):
                part_numbers.append(num)

        if debug:
            print(part_numbers)

    return sum(part_numbers)


def day_03_part_2(input: InputType, debug: bool = False) -> int:
    return -1


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

    print(day_03_part_1(test_input, debug=True))
    
    print(day_03_part_1(input))
    print(day_03_part_2(input))
