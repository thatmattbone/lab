from typing import List, Dict
from pprint import pp
from advent.util import input_path, input_lines


GameStruct = Dict[int, List[Dict[str, str]]]

def day_02_part_1(input_lines: GameStruct) -> int:
    return -1


def day_02_part_2(input_lines: List[str], debug: bool = False) -> int:
    return -1


def build_struct(input_lines: List[str]) -> GameStruct:
    print(input_lines)
    game_defs = {}
    
    for line in input_lines:
        game_id, games = line.split(':')
        game_id = int(game_id.split(' ')[-1])
        print(game_id)

        game_defs[game_id] = []

        game_turns = games.split(';')
        
        for turn in game_turns:
            turn = turn.strip()

            moves = {}
            for cubes in turn.split(','):
                cubes = cubes.strip()
                count, color = cubes.split(' ')
                count = int(count)
            
                moves[color] = count
            game_defs[game_id].append(moves)

    return game_defs
    

if __name__ == '__main__':
    input_list = input_lines(__file__)

    pp(build_struct("""\
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green""".split('\n')))
    
    print(day_02_part_1(input_list))
    print(day_02_part_2(input_list))
