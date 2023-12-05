from typing import List, Tuple

from advent.util import input_path, input_lines

InputType = List[Tuple[List[int], List[int]]]


def build_input_type(lines: List[str]) -> InputType:
    # Card   1: 99 65 21  4 72 20 77 98 27 70 | 34 84 74 18 41 45 72  2  1 75 52 47 50 93 25 10 79 87 42 69  8 12 54 96 92

    parsed = []
    
    for line in lines:
        card_info, rest = line.split(':')
        win_list_str, my_list_str = rest.split('|')

        win_list = [int(int_str.strip()) for int_str in win_list_str.split()]
        my_list = [int(int_str.strip()) for int_str in my_list_str.split()]
    
        parsed.append((win_list, my_list))
    return parsed


def day_04_part_1(input: InputType, debug: bool = False) -> int:
    if debug:
        print(input)

        return -1    


def day_04_part_2(input: InputType, debug: bool = False) -> int:
    return -1


if __name__ == '__main__':
    input_list = input_lines(__file__)
    input = build_input_type(input_list)

    test_input = """\
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11""".split('\n')
    print(day_04_part_1(build_input_type(test_input), debug=True))

    print(day_04_part_1(input))
    print(day_04_part_2(input))
