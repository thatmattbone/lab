from typing import List

from advent.util import input_path, input_lines

from .convert import MapType

# from .my_input import SEEDS, SEED_TO_SOIL, SOIL_TO_FERTILIZER, FERTILIZER_TO_WATER, WATER_TO_LIGHT, LIGHT_TO_TEMPERATURE, TEMPERATURE_TO_HUMIDITY, HUMIDITY_TO_LOCATION
from .my_test_input import SEEDS, SEED_TO_SOIL, SOIL_TO_FERTILIZER, FERTILIZER_TO_WATER, WATER_TO_LIGHT, LIGHT_TO_TEMPERATURE, TEMPERATURE_TO_HUMIDITY, HUMIDITY_TO_LOCATION


def lookup(input_map: MapType, source: int) -> int:
    for (start, end, dest) in input_map:
        if source >= start and source <= end:
            return (source - start) + dest

    return source


def day_05_part_1(debug: bool = False) -> int:
    locations = []
    
    for seed in SEEDS:
        soil = lookup(SEED_TO_SOIL, seed)
        if debug:
            print(f'seed: {seed} -> soil: {soil}')

        fertilizer = lookup(SOIL_TO_FERTILIZER, soil)
        if debug:
            print(f'soil: {soil} -> fertilizer: {fertilizer}')

        water = lookup(FERTILIZER_TO_WATER, fertilizer)
        if debug:
            print(f'fertilizer: {fertilizer} -> water: {water}')

        light = lookup(WATER_TO_LIGHT, water)
        if debug:
            print(f'water: {water} -> light: {light}')

        temperature = lookup(LIGHT_TO_TEMPERATURE, light)
        if debug:
            print(f'light: {light} -> temperature: {temperature}')

        humidity = lookup(TEMPERATURE_TO_HUMIDITY, temperature)
        if debug:
            print(f'temperature: {temperature} -> humidity: {humidity}')

        location = lookup(HUMIDITY_TO_LOCATION, humidity)
        if debug:
            print(f'humidity: {humidity} -> location: {location}')

        locations.append(location)

        if debug:
            print('==' * 25)

    return min(locations)


def day_05_part_2(debug: bool = False) -> int:
    return -1


def main():
    print(day_05_part_1(debug=False))

    print(day_05_part_2())

        
if __name__ == '__main__':
    main()
