#!/usr/bin/env python3

"""Demonstrates speed differences between script pre and post vectorisation"""

__appname__ = 'vectorize2.py'
__author__ = 'Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys  # module to interface our programe with the operating system

#import matplotlib.pylab as p
import numpy as np
import scipy as sc
import timeit
import matplotlib.pyplot as plt
import math
#import scipy.integrate as integrate

# Set random seed 
np.random.seed(1234)

## constants ##


## functions ##
def stochrick(p0 = np.random.uniform(low=0.5, high=1.5, size=10), r =1.2, K=1 , sigma =0.2, numyears = 10 ):
    """stochastic Ricker equation with gaussian fluctuations
    Gives 1000 random start values between .5 and 1.5 unless specified
    Sigma is also used later as a upper limit on random noise added"""
    
    N = np.empty((int(numyears), int(len(p0)))) #initialize empty matrix, numyear rows, P0 columns
    N[0,:] = p0 #place )all the random start values into row 1

    for pop in range(0, len(p0)):
        for yr in range(1, numyears):
            N[yr, pop ] = N[yr-1, pop] * math.exp(r * (1 - N[yr-1, pop] / K) + np.random.normal(0, sigma))
    return(N)

def stochrickvect(p0 = np.random.uniform(low=0.5, high=1.5, size=10), r =1.2, K=1 , sigma =0.2, numyears = 10 ):
    """stochastic Ricker equation with gaussian fluctuations and improved performance
    Gives 1000 random start values between .5 and 1.5 unless specified
    Sigma is also used later as a upper limit on random noise added"""
    
    N = np.empty((int(numyears), int(len(p0)))) #initialize empty matrix, numyear rows, P0 columns
    N[0,:] = p0 #place )all the random start values into row 1
    
    for yr in range(1, numyears):
            N[yr, :] = N[yr-1, :] * np.exp(r * (1 - N[yr-1, :] / K) + np.random.normal(0, sigma, len(p0)))
    return(N)

## MAIN BODY ##
def main(argv):
    """ Main entry point of the program """
    #plt.hist(stochrick(), bins=30)
    #plt.show()
    #plt.hist(stochrickvect(), bins=30)
    #plt.show()

    print("Using loops, the time taken is:")
    print(timeit.timeit(lambda: stochrick(p0 = np.random.uniform(low=0.5, high=1.5, size=1000), r =1.2, K=1 , sigma =0.2, numyears = 100 ), number=1))
    print("Using the in-built vectorised function, the time taken is:")
    print(timeit.timeit(lambda: stochrickvect(p0 = np.random.uniform(low=0.5, high=1.5, size=1000), r =1.2, K=1 , sigma =0.2, numyears = 100 ), number=1))
    return 0 

# This function makes sure the boilerplate in full when called from the terminal, then passes control to main function 
if __name__ == "__main__":
    """ Makes sure the "main" function is called from command line """
    status = main(sys.argv)
    sys.exit(status)