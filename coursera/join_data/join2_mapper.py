#!/usr/bin/env python

import sys

'''
    return rows when TV show name is "ABC"
'''


for line in sys.stdin:
    line = line.strip()
    key_value = line.split(",")
    count = 0
    chnl = ""
    tv_show = key_value[0]
    if key_value[1].isdigit():
        count = key_value[1]
    else:
        chnl = key_value[1]
    print("{0},{1},{2}".format(tv_show, chnl, count))
