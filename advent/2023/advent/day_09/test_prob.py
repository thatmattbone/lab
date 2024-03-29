from advent.util import input_lines
from .prob import day_09_part_1, day_09_part_2, build_input_type


def test_day_09_part_1():
    my_input = build_input_type(input_lines(__file__))
    assert day_09_part_1(my_input) == -1


def test_day_09_part_2():
    my_input = build_input_type(input_lines(__file__))
    assert day_09_part_2(my_input) == -1
