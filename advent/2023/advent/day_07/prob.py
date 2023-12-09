from typing import List

from advent.util import input_path, input_lines

InputType = List[str]


def build_input_type(lines: List[str]) -> InputType:
    return lines


def day_07_part_1(my_input: InputType, debug: bool = False) -> int:
    return -1    


def day_07_part_2(my_input: InputType, debug: bool = False) -> int:
    return -1


def main():
    input_list = input_lines(__file__)
    my_input = build_input_type(input_list)

    test_input = build_input_type("""\
line 1
line 2""".split('\n'))

    print(day_07_part_1(test_input, debug=True))
    print(day_07_part_1(my_input))

    print(day_07_part_2(test_input, debug=True))
    print(day_07_part_2(my_input))

        
if __name__ == '__main__':
    main()
