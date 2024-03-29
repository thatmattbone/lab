from typing import List, Tuple, Set, Dict
from copy import copy
from pprint import pp

from advent.util import input_path, input_lines

InputType = Dict[int, Tuple[Set[int], List[int]]]


def build_input_type(lines: List[str]) -> InputType:
    # Card   1: 99 65 21  4 72 20 77 98 27 70 | 34 84 74 18 41 45 72  2  1 75 52 47 50 93 25 10 79 87 42 69  8 12 54 96 92

    parsed: InputType = {}
    
    for line in lines:
        card_info, rest = line.split(':')
        _, card_num = card_info.split()
        card_num = int(card_num.strip())

        win_list_str, my_list_str = rest.split('|')
        win_list = set([int(int_str.strip()) for int_str in win_list_str.split()])
        my_list = [int(int_str.strip()) for int_str in my_list_str.split()]
    
        parsed[card_num] = (card_num, win_list, my_list)
    return parsed


def day_04_part_1(my_input: InputType, debug: bool = False) -> int:
    points = 0
    for _, win_set, my_list in my_input.values():
        wins = [i for i in my_list if i in win_set]
        if len(wins) == 0:
            continue
        else:
            points += (2**(len(wins) - 1))

    return points


def day_04_part_2(my_input: InputType, debug: bool = False) -> int:
    # if debug:
    #    print(my_input)

    # breakpoint()

    card_count = 0
    card_stack = list(my_input.values())
    card_stack.reverse()

    if debug:
        pp(card_stack)
        print('==' * 25)
    
    while len(card_stack) > 0:
        card_count += 1
        card_num, win_set, my_list = card_stack.pop()
        wins = [i for i in my_list if i in win_set]
        
        for i in range(1, 1 + len(wins)):
            card_stack.append(my_input[card_num + i])

        if debug:
            print(card_count)
            pp(card_stack)
            print(f'{card_num}: {win_set} | {my_list} -> {len(wins)})')
            print('==' * 25)
            breakpoint()

            
    return card_count


def day_04_part_2_faster(my_input: InputType, debug: bool = False) -> int:
    # if debug:
    #    print(my_input)

    # breakpoint()

    counts = [1 for _ in range(len(my_input))]

    for card_num, win_set, my_list in my_input.values():
        wins = [i for i in my_list if i in win_set]

        my_card_count = counts[card_num - 1]
        for i in range(0, len(wins)):            
            counts[card_num + i] += my_card_count

        if debug:
            print(f'{card_num}: {win_set} | {my_list} -> {len(wins)})')
            pp(counts)
            print('==' * 25)
            breakpoint()
            
    return sum(counts)


def main():
    input_list = input_lines(__file__)
    my_input = build_input_type(input_list)

    test_input = build_input_type("""\
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11""".split('\n'))
    
    print(day_04_part_1(test_input))
    print(day_04_part_1(my_input))

    print(day_04_part_2_faster(test_input, debug=False))
    print(day_04_part_2_faster(my_input))


if __name__ == '__main__':
    main()
