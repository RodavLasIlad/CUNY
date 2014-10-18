# -*- coding: utf-8 -*-
"""
Created on Thu Oct 02 08:30:09 2014

@author: Brett
"""

"""
Load in brainandbody.csv
perform linear regression using least squares on the relationship of brain 
weight (br) to body weight (bo). The model should be bo = X * br + Y
"""
import csv
import re
import numpy as np
from scipy.optimize import curve_fit
def scipys():
    vals = []
    with open('C:\\Users\\Brett\\Documents\\Data\\brainandbody.csv', 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=",")
        for row in reader:
            vals.append(row)
    # Quick header remover:
    vals.pop(0)
    # Converting strings to numbers:
    brain = []
    body = []
    for i in range(len(vals)):
        body.append(float(vals[i][1]))
        brain.append(float(vals[i][2]))
        
    def func(x, a, b):
        return a * x + b
    popt, pcov = curve_fit(func, body, brain)
    print  "bo = " + str(popt[0]) + " * br + " + str(popt[1])
    
def mine():
    vals = []
    with open('C:\\Users\\Brett\\Documents\\Data\\brainandbody.csv', 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=",")
        for row in reader:
            vals.append(row)
    # Quick header remover:
    vals.pop(0)
    # Converting strings to numbers:
    brain = []
    body = []
    for i in range(len(vals)):
        vals[i][1] = float(vals[i][1])
        vals[i][2] = float(vals[i][2])    
    
    # Finding the means:
    boMean = 0
    brMean = 0
    for i in range(len(vals)):
        boMean += vals[i][1]
        brMean += vals[i][2]
    boMean = boMean / float(len(vals))
    brMean = brMean / float(len(vals))
    # Calculating the distance and the mean squared error
    meanDist = 0
    mse = 0
    for i in range(len(vals)):
        meanDist += (vals[i][1] - boMean) * (vals[i][2] - brMean)
        # Base functions only, so I didn't use math to square
        mse += (vals[i][1] - boMean) * (vals[i][1] - boMean)
    # Calculating the slope:
    slope = meanDist / mse
    # Calculating the intercept:
    constant = brMean - (slope * boMean)
    # Returning to console:
    print "bo = " + str(slope) + " * br + " + str(constant)

if __name__ == "__main__":
    import timeit as ti
    print "Using ten iterations for each\n\n"
    print "Scipys Approach: " + str(ti.timeit("scipys()", setup="from __main__ import scipys", number=10))
    print "My Approach: " + str(ti.timeit("mine()", "from __main__ import mine", number=10))