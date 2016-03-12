#!/usr/bin/env python

import sys

'''
 (In pseudo-SQL it migth be something like: Select sum( viewer count) from File A, File B where FileA.TV show = FileB.TV show and FileB.Channel='ABC' grouped by TV show)
'''

chnl_abc = 'ABC'
prev_tv_show = ""

for line in sys.stdin:
    line = line.strip()
    value_in = line.split(",")
    
    cur_tv_show = value_in[0]
    
    if cur_tv_show != prev_tv_show:
        prev_tv_show = cur_tv_show
        tv_show_count = 0
        
    if value_in[1] == "":
        tv_show_count += int(value_in[2])
    
    elif value_in[1] == chnl_abc:
        print("{0} {1}".format(cur_tv_show,tv_show_count))
        
        

         
    
