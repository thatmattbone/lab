from typing import List, Tuple

from advent.util import input_path, input_lines

InputType = List[Tuple[int, int]]


def run_race(time: int, distance: int, debug: bool = False) -> int:
    records = []
    
    for i in range(time):
        my_distance = i * (time - i)
        if my_distance > distance:
            if debug:
                print(f'my distance: {my_distance} > {distance}')
            
            records.append((my_distance, distance))

    return records


def day_06_part_1(my_input: InputType, debug: bool = False) -> int:
    answer = 1
    
    for time, distance in my_input:
        records = run_race(time, distance, debug=debug)
        if debug:            
            print('==' * 25)
        answer *= len(records)

    return answer


def day_06_part_2(my_input: InputType, debug: bool = False) -> int:
    answer = 1
    
    for time, distance in my_input:
        records = run_race(time, distance, debug=debug)
        if debug:            
            print('==' * 25)
        answer *= len(records)

    return answer


def main():
    # Time:        49     87     78     95
    # Distance:   356   1378   1502   1882

    my_input = [
        (49, 356),
        (87, 1378),
        (78, 1502),
        (95, 1882),
    ]

    
    # Time:      7  15   30
    # Distance:  9  40  200    
    test_input = [
        (7, 9),
        (15, 40),
        (30, 200),
    ]


    test_input_part_2 = [
        (71530, 940200),
    ]
    my_input_part_2 = [
        (49877895, 356137815021882),
    ]
    

    print(day_06_part_1(test_input, debug=True))
    print(day_06_part_1(my_input))

    print(day_06_part_2(test_input_part_2, debug=True))
    print(day_06_part_2(my_input_part_2))

        
if __name__ == '__main__':
    main()
