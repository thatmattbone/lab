from typing import List, Tuple

# destination range start, the source range start, and the range length

MapType = List[Tuple[int, int, int]]

def convert_map(map_str: str) -> MapType:
    my_map = []
    for line in map_str.split('\n'):
        dest_range_start, source_range_start, range_len = [int(i) for i in line.split()]

        map_tuple = (source_range_start, source_range_start + range_len, dest_range_start)
        my_map.append(map_tuple)
    return my_map                      
