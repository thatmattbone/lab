from advent.util import input_lines
from .prob import day_1_part_1, day_1_part_2


def test_day_1_part_1():
    assert day_1_part_1(input_lines(__file__)) == 54338

def test_day_2_part_2():
    assert day_1_part_2(input_lines(__file__)) == 53389
