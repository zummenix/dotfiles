#!/usr/bin/env python3

# The script uses the ImageMagic's `convert` tool to resize app icons.

"""
Script receives a single argument: path to .png file.
Usage example:
    app_icon_resize.py image.png
"""

import os
from subprocess import call
import sys


SIZES = [
    (40, 1),
    (58, 1),
    (60, 1),
    (80, 1),
    (87, 1),
    (120, 1),
    (180, 1),
    (1024, 1)
]


def resize(original, size, scale):
    file_name = format_name(size, scale)
    print(file_name)
    side = str(int(size * scale))
    call(["convert", original, "-alpha", "off",
          "-resize", side + "x" + side, file_name])


def format_name(size, scale):
    return str(size) + "@" + str(scale) + "x" + ".png"


def test_format_name():
    assert format_name(24, 2) == "24@2x.png"


def get_original_path():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    original = sys.argv[1]
    if os.path.exists(original):
        return original
    sys.exit(f'Path does not exist: "{original}".')


original = get_original_path()
for (size, scale) in SIZES:
    resize(original, size, scale)
