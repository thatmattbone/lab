from advent.util import input_lines
from .prob import day_07_part_1, day_07_part_2, build_input_type


def test_day_07_part_1():
    my_input = build_input_type(input_lines(__file__))
    assert day_07_part_1(my_input) == -1


def test_day_07_part_2():
    my_input = build_input_type(input_lines(__file__))
    assert day_07_part_2(my_input) == -1
