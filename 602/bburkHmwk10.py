# -*- coding: utf-8 -*-
"""
Created on Tue Nov 18 08:15:06 2014

@author: Brett
"""
import pandas as pd
import matplotlib.pyplot as plt
import scipy.ndimage as ndimage
import scipy.misc as misc
import numpy as np
from collections import Counter

########## Plotting Cars Data ##########
cars = pd.read_csv('C:\\Users\\Brett\\Documents\\Data\\cars.data.csv', 
                  names = ['buying', 'maint', 'doors', 'ppl', 'lug', 'safe', 'class'],
#                  parse_dates = ['date'],
                  header = None)
                 
fig = plt.figure()

##### Buying ######
counter = Counter(cars['buying'])
buying_names = counter.keys()
buying_counts = counter.values()
b_indexes = np.arange(len(buying_names))

ax1 = fig.add_subplot(221)
ax1.bar(b_indexes, buying_counts, 1)
ax1.set_xticks(b_indexes + 0.5)
ax1.set_xticklabels(buying_names)

##### Maintenance #####
counter = Counter(cars['maint'])
maint_names = counter.keys()
maint_counts = counter.values()
m_indexes = np.arange(len(maint_names))

ax2 = fig.add_subplot(222)
ax2.bar(m_indexes, maint_counts, 1)
ax2.set_xticks(m_indexes + 0.5)
ax2.set_xticklabels(maint_names)

##### Safety #####
counter = Counter(cars['safe'])
safety_names = counter.keys()
safety_counts = counter.values()
s_indexes = np.arange(len(safety_names))

ax3 = fig.add_subplot(223)
ax3.bar(s_indexes, safety_counts, 1)
ax3.set_xticks(s_indexes + 0.5)
ax3.set_xticklabels(safety_names)

##### Doors #####
counter = Counter(cars['doors'])
doors_names = counter.keys()
doors_counts = counter.values()
d_indexes = np.arange(len(doors_names))

ax4 = fig.add_subplot(224)
ax4.bar(d_indexes, doors_counts, 1)
ax4.set_xticks(d_indexes + 0.7 * 0.5)
ax4.set_xticklabels(doors_names)

plt.show()
plt.close()
########## Linear Regression Plotting ##########
brbody = pd.read_csv('C:\\Users\\Brett\\Documents\\Data\\brainandbody.csv', header = 0)
# Finding the means:
m, b = np.polyfit(brbody['body'], brbody['brain'], 1)
plt.plot(brbody['body'], brbody['brain'], '.')
plt.plot(brbody['body'], m*brbody['body'] + b, '-')

########## Overlay of centers ##########

data_dir = 'C:\\Users\\Brett\\Documents\\Data\\'
imgs = 'objects.png'
raw = misc.imread(data_dir + imgs)

# Using a gaussian filter with a sigma of 2 to threshold
img = ndimage.gaussian_filter(raw, 2)
thresh = img > img.mean()

# Using labels to count the objects
lbls = ndimage.label(thresh)
nrObj = lbls[1]
print "Object count: " + str(nrObj)
print "\n"

# Finding the centers using center of mass
centers = ndimage.center_of_mass(thresh, lbls[0], np.arange(1, nrObj + 1, 1))
plt.imshow(raw)
centers = pd.DataFrame(centers)
plt.scatter(centers[0], centers[1])

########## Server access ##########
epa = pd.read_csv('C:\\Users\\Brett\\Documents\\Data\\epa-http.txt', 
                  delim_whitespace = True, 
                  error_bad_lines = False,
                  names = ['host', 'date', 'request', 'reply-code', 'bytes'],
                  header = None)

for i in range(len(epa)):
   epa['date'][i] = epa['date'][i][1:-1]
   tmp = epa['date'][i].split(':')
   epa['date'][i] = tmp[0] + tmp[1]
# While I could have parsed this to datetime, using pd.to_datetime() it would have been completely redundant considering there are only 2 days, and thus only two copies of each hour,
   # especially given the format the data came in, which would have taken as much processing to get it into pandas format, before talking about using .hour to groupby

# Dropping the altgif rows, as they don't contribute any information and are erroneus (is it supposed to be alt.gif=" ? likely there is supposed to be more information there)

bH = epa['date'].value_counts()
bHi = []
for i in range(len(bH)):
    bHi.append([bH.index[i], bH[i]])
bHi.sort()
bHi = pd.DataFrame(bHi)

plt.plot(bHi[0], bHi[1], '.')
plt.plot(bHi[0], bHi[1], '-')