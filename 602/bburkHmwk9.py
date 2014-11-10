
# coding: utf-8

import csv
import pandas as pd
import numpy as np

epa = pd.read_csv('C:\\Users\\Brett\\Documents\\Data\\epa-http.txt', 
                  delim_whitespace = True, 
                  error_bad_lines = False,
                  names = ['host', 'date', 'request', 'reply-code', 'bytes'],
#                  parse_dates = ['date'],
                  header = None)



for i in range(len(epa['bytes'])):
    if not epa['bytes'][i].isdigit():
       epa['bytes'][i] = 0
       
epa['bytes'] = epa['bytes'].astype(int)

for i in range(len(epa)):
   epa['date'][i] = epa['date'][i][1:-1]
   tmp = epa['date'][i].split(':')
   epa['date'][i] = "Day: " + tmp[0] + " Hour: " + tmp[1]
# While I could have parsed this to datetime, using pd.to_datetime() it would have been completely redundant considering there are only 2 days, and thus only two copies of each hour,
   # especially given the format the data came in, which would have taken as much processing to get it into pandas format, before talking about using .hour to groupby

# Dropping the altgif rows, as they don't contribute any information and are erroneus (is it supposed to be alt.gif=" ? likely there is supposed to be more information there)
epa = epa[epa['reply-code'] != 'HTTP/1.0"']


##### 1 #####
hostRequestsMost = epa['host'].value_counts().index[0]


##### 2 #####
sortedByBytes = epa.groupby('host').sum().sort('bytes', ascending=False)['bytes']

##### 3 #####

busiestHour = epa['date'].value_counts().index[0]

##### 4 #####
# get /image.gif HTTP/1.0
gifs = epa[epa['request'].str.contains('gif')]
gifsMost = gifs['request'].value_counts().index[0]

##### 5 #####
replies = epa['reply-code'].unique()
repNotTwoHundo = replies[replies != '200']

##### Output #####
# 1
print '*' *25
print '#1'
print 'Most requests made by: '
print hostRequestsMost
print '*' *25
# 2
print '#2'
print 'Most received bytes by: '
print sortedByBytes.index[0]
print 'Received bytes: '
print sortedByBytes[0]
print '*' *25
# 3
print '#3'
print 'Busiest hour: '
print busiestHour
print '*' *25
# 4
print '#4'
print 'Most downloaded gif: '
print gifsMost
print '*' *25
# 5
print '#5'
print 'HTTP Reply codes other than 200: '
print repNotTwoHundo
print '*' *25