from advent.util import input_lines
from .prob import day_02_part_1, day_02_part_2, build_struct


def _get_input():
    return build_struct(input_lines(__file__))

def test_day_02_part_1():
    assert day_02_part_1(_get_input()) == 2632

def test_day_02_part_2():
    assert day_02_part_2(_get_input()) == 69629
