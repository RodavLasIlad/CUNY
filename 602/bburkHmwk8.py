# -*- coding: utf-8 -*-
"""
Created on Thu Oct 30 08:41:23 2014

@author: Brett
"""

import scipy.ndimage as ndimage
import scipy.misc as misc
import numpy as np

data_dir = 'C:\\Users\\Brett\\Documents\\Data\\'
imgs = ['circles.png', 'objects.png', 'peppers.png']
for i in range(len(imgs)):
    print "-" * 30
    print imgs[i][0:-4]
    # Loading in the file
    raw = misc.imread(data_dir + imgs[i])
    
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
    for j in range(len(centers)):
        print "Object #" + str(j+1) + "'s center:"
        print "x = " + str(centers[j][0])
        print "y = " + str(centers[j][1])
        print "\n"