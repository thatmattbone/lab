from collections import Counter
from pprint import pp
from typing import List, Tuple
from enum import Enum
from functools import total_ordering
from itertools import batched

from advent.util import input_path, input_lines

CARD_VALS = {
    'A': 14,
    'K': 13,
    'Q': 12,
    'J': 11,
    'T': 10,
    '9': 9,
    '8': 8,
    '7': 7, 
    '6': 6,
    '5': 5
    '4': 4,
    '3': 3;
    '2': 2,
}


class HandType(Enum):
    FIVE_OF_KIND = 700
    FOUR_OF_KIND = 500
    FULL_HOUSE = 600
    THREE_OF_KIND = 400
    TWO_PAIR = 300
    ONE_PAIR = 200
    HIGH_CARD = 100

    
@total_ordering
class Hand:
    def __init__(self, hand_str: str):
        self.hand_str = hand_str
        self.hand_type = self.find_type(hand_str)

    def find_type(self, hand_str: str) -> HandType:
        counter = Counter(hand_str)
        counter_val_set = set(counter.values())
        
        if len(counter) == 1:
            return HandType.FIVE_OF_KIND

        elif len(counter) == 2 and counter_val_set == {1, 4}:
            return HandType.FOUR_OF_KIND

        elif len(counter) == 2 and counter_val_set == {2, 3}:
            return HandType.FULL_HOUSE

        elif len(counter) == 3 and counter_val_set == {1, 3}:
            return HandType.THREE_OF_KIND

        elif len(counter) == 3 and counter_val_set == {1, 2}:
            return HandType.TWO_PAIR

        elif len(counter) == 4:
            return HandType.ONE_PAIR
            
        elif len(counter) == 5:
            return HandType.HIGH_CARD

        raise ValueError(hand_str)

    def __str__(self):
        return f'{self.hand_type.name}: {self.hand_str}'

    def __repr__(self):
        return str(self)

    def __eq__(self, other):
        if self.hand_str == other.hand_str:
            return True
        return False

    def __lt__(self, other):
        if self.hand_type == other.hand_type:
            different_cards = [(i, j) for i, j in zip(self.hand_str, other.hand_str) if i != j]

            my_card, their_card = different_cards[0]

            if CARD_VALS[my_card] < CARD_VALS[their_card]:
                return True
            else:
                return False
        else:
            if self.hand_type.value < other.hand_type.value:
                return True
            else:
                return False


InputType = List[Tuple[Hand, int]]
    

def build_input_type(lines: List[str]) -> InputType:
    fixed_lines = []
    for line in lines:
        hand, bid = line.split()
        bid = int(bid)
        fixed_lines.append((Hand(hand), bid))
    return fixed_lines


def day_07_part_1(my_input: InputType, debug: bool = False) -> int:
    if debug:
        pp(my_input)

    for five_hands in batched(my_input, n=5):
        five_hands.sort(lambda x: x[0])

        if debug:
            for hand, bid in five_hands:
                print(f'{hand}: {bid}')
    return -1    


def day_07_part_2(my_input: InputType, debug: bool = False) -> int:
    return -1


def main():
    input_list = input_lines(__file__)
    my_input = build_input_type(input_list)

    test_input = build_input_type("""\
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483""".split('\n'))

    print(day_07_part_1(test_input, debug=True))
    print(day_07_part_1(my_input))

    print(day_07_part_2(test_input, debug=True))
    print(day_07_part_2(my_input))

        
if __name__ == '__main__':
    main()
