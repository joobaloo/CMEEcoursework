#!/usr/bin/env python3

"""Demonstrates speed differences between script pre and post vectorisation"""

__appname__ = 'vectorize1.py'
__author__ = 'Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys  # module to interface our programe with the operating system

#import matplotlib.pylab as p
import numpy as np
import scipy as sc
import timeit
#import scipy.integrate as integrate

# Set random seed 
np.random.seed(1234)

## constants ##
M = np.random.uniform(low=0.0, high=1.0, size= 100) 
MM = M.reshape(10,10)

## functions ##
def SumAllElements(MM):
    """Sums all the elements of a matrix using loops"""
    dimensions = MM.shape
    total = 0
    # for each row 
    for i in range (0, dimensions[0]) :
        for j in range (0, dimensions[1]):
            total = total + MM[i,j]

    return (total)

def VectSum(MM):
    """Sums all the elemts using vctorisation"""
    vecttot = MM.sum()
    return(vecttot)

def main(argv):
    """ Main entry point of the program """
    
    print("Using loops, the time taken is:")
    print(timeit.timeit(stmt="SumAllElements(MM)", setup="import numpy as np; M = np.random.uniform(low=0.0, high=1.0, size= 100); MM = M.reshape(10,10); from __main__ import SumAllElements"))
    print("Using the in-built vectorised function, the time taken is:")
    print(timeit.timeit(stmt="VectSum(MM)", setup="import numpy as np; M = np.random.uniform(low=0.0, high=1.0, size= 100); MM = M.reshape(10,10); from __main__ import VectSum"))
    return 0 

# This function makes sure the boilerplate in full when called from the terminal, then passes control to main function 
if __name__ == "__main__":
    """ Makes sure the "main" function is called from command line """
    status = main(sys.argv)
    sys.exit(status)