#!/usr/bin/env pythons

""" Calculates tree heights given distance of each tree 
from its base and angle to its top, using  the trigonometric formula. 
Outputs to csv called INPUT_FILE_NAME_treeheights_py.csv"""


__appname__ = 'get_TreeHeight.py'
__author__ = 'Elliott Parnell (elliott.parnell22@imperial.ac.uk), Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (L.feng22@imperial.ac.uk)'
__version__ = '0.0.1'

## Imports ##
import numpy as np
import os
import csv
import sys

## Functions ##
def TreeHeight(degrees, distance):
    """Calculate tree heights"""
    radians = degrees * np.pi / 180
    height = distance * np.tan(radians)
    return height  

# Data loaded from command line 
if len(sys.argv) != 2:  # wrong input, exit directly
    print("One(just one) .csv file needed.")
    sys.exit("Please give right input. Try again.") 
    
else:
    with open(sys.argv[1], 'r') as a: 
        data = []    # setup an empty list for data storation
        
        for j in csv.reader(a): 
            data.append(j) 
        data.remove(data[0]) # remove header
            
        for i in data:
            i[1] = float(i[1])
            i[2] = float(i[2])
            i.append(TreeHeight(i[2], i[1])) # save height output to 3rd col
       
       #Write csv results
        with open("../results/"+ os.path.basename(os.path.splitext(sys.argv[1])[0]) + "_treeheights_py.csv", 'w') as b:   
            csv.writer(b).writerow(['Species', 'Distance.m', 'Angle.degrees', 'Tree.Height.m']) # header  ordered
            for t in data:
                csv.writer(b).writerow(t) 

              
