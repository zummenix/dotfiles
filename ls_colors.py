#!/usr/bin/env python3

fg = '\033[38;5;'
bg = '\033[48;5;'

def format_color(index):
    n = str(index)
    fgstr = fg + n + 'm' + n + '\t'
    bgstr = bg + n + 'm' + 'XXXXX'
    return fgstr + bgstr + '\033[0m'

def test_format_color():
    assert format_color(5) == "\033[38;5;5m5\t\033[48;5;5mXXXXX\033[0m"
    assert format_color(128) == "\033[38;5;128m128\t\033[48;5;128mXXXXX\033[0m"

for i in range(0, 256):
    print(format_color(i))
