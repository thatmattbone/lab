from itertools import cycle
from typing import List, Dict, Tuple

from advent.util import input_path, input_lines

MapStruct = Dict[str, Tuple[str, str]]
InputType = Tuple[str, MapStruct]


def build_input_type(lines: List[str]) -> InputType:
    instructions = lines[0].strip()

    map_struct = {}
    for line in lines[1:]:
        if line:
            source, dest = line.split(' = ')
            left, right = dest[1:-1].split(', ')

            map_struct[source] = (left, right)

    return instructions, map_struct


def day_08_part_1(my_input: InputType, debug: bool = False) -> int:
    if debug:
        print(my_input)

    instructions, map_struct = my_input

    steps = 1
    current_location = 'AAA'
    for instruction in cycle(instructions):
        if debug:
            print(f'current: {current_location} going {instruction}')

        if instruction == 'L':
            next_location = map_struct[current_location][0]
        elif instruction == 'R':
            next_location = map_struct[current_location][1]
        else:
            raise ValueError()

        if next_location == 'ZZZ':
            break

        steps += 1
        current_location = next_location

    return steps


def day_08_part_2(my_input: InputType, debug: bool = False) -> int:
    instructions, map_struct = my_input

    start_nodes = [key for key in map_struct.keys() if key.endswith('A')]
    end_nodes = [key for key in map_struct.keys() if key.endswith('Z')]

    def _all_dest(current_nodes):
        return all([node.endswith('Z') for node in current_nodes])

    if debug:
        print(start_nodes)
        print(end_nodes)

    steps = 1
    current_nodes = start_nodes
    for instruction in cycle(instructions):
        if debug:
            print(f'current: {current_nodes} going {instruction}')

        new_current_nodes = []
        for node in current_nodes:
            if instruction == 'L':
                next_node = map_struct[node][0]
            elif instruction == 'R':
                next_node = map_struct[node][1]
            else:
                raise ValueError()

            new_current_nodes.append(next_node)

        if _all_dest(new_current_nodes):
            break

        steps += 1
        current_nodes = new_current_nodes

    return steps


def main():
    input_list = input_lines(__file__)
    my_input = build_input_type(input_list)

    test_input = build_input_type("""\
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)""".split('\n'))

    test_input2 = build_input_type("""\
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
""".split('\n'))

    test_input3 = build_input_type("""\
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)""".split('\n'))

    # print(day_08_part_1(test_input, debug=True))
    # print(day_08_part_1(test_input2, debug=True))
    # print(day_08_part_1(my_input))

    print(day_08_part_2(test_input3, debug=True))
    print(day_08_part_2(my_input))

        
if __name__ == '__main__':
    main()
