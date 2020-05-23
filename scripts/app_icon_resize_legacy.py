#!/usr/bin/env python3

# The script uses the ImageMagic's `convert` tool to resize app icons.

"""
Script receives a single argument: path to .png file.
Usage example:
    app_icon_resize_legacy.py image.png
"""

import os
from subprocess import call
import sys


SIZES = [
    (20, 1),
    (20, 2),
    (20, 3),
    (24, 2),
    (27.5, 2),
    (29, 1),
    (29, 2),
    (29, 3),
    (40, 1),
    (40, 2),
    (40, 3),
    (44, 2),
    (50, 1),
    (50, 2),
    (57, 1),
    (57, 2),
    (60, 2),
    (60, 3),
    (72, 1),
    (72, 2),
    (76, 1),
    (76, 2),
    (83.5, 2),
    (86, 2),
    (98, 2),
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
