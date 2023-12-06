from advent.util import input_lines
from .prob import day_04_part_1, day_04_part_2_faster as day_04_part_2, build_input_type


def test_day_04_part_1():
    my_input = build_input_type(input_lines(__file__))
    assert day_04_part_1(my_input) == 32609


def test_day_04_part_2():
    my_input = build_input_type(input_lines(__file__))
    assert day_04_part_2(my_input) == 14624680
