#!/usr/bin/env python

from subprocess import call
import os

def format_name(size, scale):
    return str(size) + "@" + str(scale) + "x"

def resize(size, scale):
    name = format_name(size, scale)
    file_name = name + ".png"
    file_path = name + "/" + file_name
    call(["mkdir", name])
    call(["cp", "icon.png", file_path])
    call(["sips", "-Z", str(int(size * scale)), file_path])
    call(["mv", file_path, "."])
    call(["rm", "-rf", name])

def sizes():
    return [
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

for (size, scale) in sizes():
    resize(size, scale)
