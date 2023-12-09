from .convert import convert_map


SEEDS = [79, 14, 55, 13]


SEED_TO_SOIL = convert_map("""\
50 98 2
52 50 48""")


SOIL_TO_FERTILIZER = convert_map("""\
0 15 37
37 52 2
39 0 15""")


FERTILIZER_TO_WATER = convert_map("""\
49 53 8
0 11 42
42 0 7
57 7 4""")


WATER_TO_LIGHT = convert_map("""\
88 18 7
18 25 70""")


LIGHT_TO_TEMPERATURE = convert_map("""\
45 77 23
81 45 19
68 64 13""")


TEMPERATURE_TO_HUMIDITY = convert_map("""\
0 69 1
1 0 69""")


HUMIDITY_TO_LOCATION = convert_map("""\
60 56 37
56 93 4""")
