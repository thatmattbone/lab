from typing import List

from advent.util import input_path, input_lines

InputType = List[str]


def build_input_type(lines: List[str]) -> InputType:
    pass


def day_03_part_1(input: InputType, debug: bool = False) -> int:
    return -1    


def day_03_part_2(input: InputType, debug: bool = False) -> int:
    return -1


if __name__ == '__main__':
    input_list = input_lines(__file__)
    input = build_input_type(input_list)

    print(day_03_part_1(input))
    print(day_03_part_2(input))
