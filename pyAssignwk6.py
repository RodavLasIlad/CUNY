# -*- coding: utf-8 -*-
"""
This file loads in a text file that holds the following:

1 Germany  | W 3 | T 4 | W 2
2 United States | W 4 | T 3 | L 1
3 Portugal | L 1 | T 2 | W 4
4 Ghana | L 2 | T 1 | L 3

and then uses regular expressions to parse the values
"""
import re
txt = open('C:\Users\Brett\Dropbox\CUNY\week6pyAssign.txt', 'r')
for line in txt:
    try:
        line=line.rstrip()
        print 'Rank: ' + re.findall('^[0-9]', line)[0]
        print 'Country: ' + re.findall('[A-Z][a-z]+', line)[0]
        x = re.findall('[W,L,T]\s[0-9]', line)
        print 'Results: '
        for i in x:
            print i
        print ''
    except ValueError:
        continue
txt.close()