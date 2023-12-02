import os
from typing import List


def input_path(script_path: str, input_filename: str='input') -> str:
    return os.path.join(os.path.dirname(script_path), input_filename)


def input_lines(script_path: str, input_filename: str = 'input') -> List[str]:
    input_lines = []

    with open(input_path(script_path)) as lines:
        for line in lines:
            input_lines.append(line.strip())

    return input_lines
