import os
import sys


if __name__ == '__main__':
    if len(sys.argv) != 2 and not sys.argv[-1].isnumber():
        sys.exit('you must specify a numeric day')

    day = int(sys.argv[-1])
    if day < 10:
        day_dir = f'day_0{day}'
    else:
        day_dir = f'day_{day}'

    full_path = os.path.join(os.path.dirname(__file__), day_dir)

    if os.path.exists(full_path):
        sys.exit(f'{day_dir} already exists at: {full_path}')

    os.mkdir(full_path)

    with open(os.path.join(full_path, '__init__.py'), 'w'):
        pass

    with open(os.path.join(full_path, 'prob.py'), 'w') as prob_file:
        contents = f"""\
from typing import List

from advent.util import input_path, input_lines

InputType = List[str]


def build_input_type(lines: List[str]) -> InputType:
    return lines


def {day_dir}_part_1(my_input: InputType, debug: bool = False) -> int:
    return -1    


def {day_dir}_part_2(my_input: InputType, debug: bool = False) -> int:
    return -1


def main():
    input_list = input_lines(__file__)
    my_input = build_input_type(input_list)

    test_input = build_input_type(\"\"\"\\
line 1
line 2\"\"\".split('\\n'))

    print({day_dir}_part_1(test_input, debug=True))
    print({day_dir}_part_1(my_input))

    print({day_dir}_part_2(test_input, debug=True))
    print({day_dir}_part_2(my_input))

        
if __name__ == '__main__':
    main()
"""
        prob_file.write(contents)

    with open(os.path.join(full_path, 'test_prob.py'), 'w') as test_file:
        contents = f"""\
from advent.util import input_lines
from .prob import {day_dir}_part_1, {day_dir}_part_2, build_input_type


def test_{day_dir}_part_1():
    my_input = build_input_type(input_lines(__file__))
    assert {day_dir}_part_1(my_input) == -1


def test_{day_dir}_part_2():
    my_input = build_input_type(input_lines(__file__))
    assert {day_dir}_part_2(my_input) == -1
"""
        test_file.write(contents)

#     with open(os.path.join(full_path, 'input'), 'w') as test_file:
#         contents = f"""\
# hello
# world
# """
#         test_file.write(contents)
