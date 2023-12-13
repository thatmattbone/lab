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
    '5': 5,
    '4': 4,
    '3': 3,
    '2': 2,
}


JOKER_CARD_VALS = {
    'A': 14,
    'K': 13,
    'Q': 12,
    'T': 10,
    '9': 9,
    '8': 8,
    '7': 7, 
    '6': 6,
    '5': 5,
    '4': 4,
    '3': 3,
    '2': 2,
    'J': 1,    
}


class HandType(Enum):
    FIVE_OF_KIND = 700
    FOUR_OF_KIND = 600
    FULL_HOUSE = 500
    THREE_OF_KIND = 400
    TWO_PAIR = 300
    ONE_PAIR = 200
    HIGH_CARD = 100

    
@total_ordering
class Hand:
    def __init__(self, hand_str: str, jokerfy: bool = False):
        self.hand_str = hand_str
        self._hand_type = self.find_type(hand_str)

        self.is_jokerfied = jokerfy
        
        self.joker_hand_type = None
        if jokerfy:
            self.joker_hand_type = self.jokerfy()

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

    def jokerfy(self) -> HandType:
        if 'J' not in self.hand_str:
            return self.hand_type
        elif 'JJJJJ' == self.hand_str:
            return self.hand_type

        j_count = len([j for j in self.hand_str if j == 'J'])

        if self._hand_type == HandType.FOUR_OF_KIND:
            return HandType.FIVE_OF_KIND

        elif self._hand_type == HandType.FULL_HOUSE:
            if j_count == 2:
                return HandType.FIVE_OF_KIND
            elif j_count == 3:
                return HandType.FIVE_OF_KIND
            else:
                raise ValueError(self.hand_str)

        elif self._hand_type == HandType.THREE_OF_KIND:
            if j_count == 1:
                return HandType.FOUR_OF_KIND
            elif j_count == 3:
                return HandType.FOUR_OF_KIND
            else:
                raise ValueError(self.hand_str)

        elif self._hand_type == HandType.TWO_PAIR:
            if j_count == 1:
                return HandType.FULL_HOUSE
            elif j_count == 2:
                return HandType.FOUR_OF_KIND
            else:
                raise ValueError(self.hand_str)
   
        elif self._hand_type == HandType.ONE_PAIR:
            if j_count == 1:
                return HandType.THREE_OF_KIND
            elif j_count == 2:                
                return HandType.THREE_OF_KIND
            else:
                raise ValueError(self.hand_str)

        elif self._hand_type == HandType.HIGH_CARD:
            if j_count == 1:
                return HandType.ONE_PAIR
            else:
                raise ValueError(self.hand_str)

        raise ValueError(self.hand_str)

    @property
    def hand_type(self):
        if self.joker_hand_type:
            return self.joker_hand_type
        return self._hand_type

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

            if self.is_jokerfied:
                if JOKER_CARD_VALS[my_card] < JOKER_CARD_VALS[their_card]:
                    return True
                else:
                    return False
            else:
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
    

def build_input_type(lines: List[str], jokerfy: bool = False) -> InputType:
    fixed_lines = []
    for line in lines:
        hand, bid = line.split()
        bid = int(bid)
        fixed_lines.append((Hand(hand, jokerfy=jokerfy), bid))
    return fixed_lines


def day_07_part_1(my_input: InputType, debug: bool = False) -> int:
    answer = 0
    
    my_input.sort(key=lambda x: x[0])

    for rank, (hand, bid) in enumerate(my_input, start=1):
        if debug:
            print(f'{rank} -- {hand}: {bid}')

        answer += (rank * bid)

    return answer


def day_07_part_2(my_input: InputType, debug: bool = False) -> int:
    return day_07_part_1(my_input, debug=debug)


def main():
    test_input_lines = """\
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483""".split('\n')

    input_list = input_lines(__file__)
    
    print(day_07_part_1(build_input_type(test_input_lines), debug=True))
    print(day_07_part_1(build_input_type(input_list)))
    
    print(day_07_part_2(build_input_type(test_input_lines, jokerfy=True), debug=True))
    print(day_07_part_2(build_input_type(input_list, jokerfy=True)))

        
if __name__ == '__main__':
    main()
