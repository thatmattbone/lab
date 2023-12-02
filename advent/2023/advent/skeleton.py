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
    pass


def {day_dir}_part_1(input: InputType, debug: bool = False) -> int:
    return -1    


def {day_dir}_part_2(input: InputType, debug: bool = False) -> int:
    return -1


if __name__ == '__main__':
    input_list = input_lines(__file__)
    input = build_input_type(input_list)

    print({day_dir}_part_1(input))
    print({day_dir}_part_2(input))
"""
        prob_file.write(contents)

    with open(os.path.join(full_path, 'test_prob.py'), 'w') as test_file:
        contents = f"""\
from advent.util import input_lines
from .prob import {day_dir}_part_1, {day_dir}_part_2


def test_{day_dir}_part_1():
    assert {day_dir}_part_1(input_lines(__file__)) == -1

def test_{day_dir}_part_2():
    assert {day_dir}_part_2(input_lines(__file__)) == -1
"""
        test_file.write(contents)

    with open(os.path.join(full_path, 'input'), 'w') as test_file:
        contents = f"""\
hello
world
"""
        test_file.write(contents)
