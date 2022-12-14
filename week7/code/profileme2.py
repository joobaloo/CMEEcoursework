#!/usr/bin/env python3

""" profiling in ipython but with list comprehensions"""

__appname__ = 'profileme2.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

#importing module
import numpy as np

def my_squares(iters):
    """ function that produces a list of squared numbers """
    out = np.ones((iters, 1))
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """ function that joins an input string together separated by a comma"""
    out = ''
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """ function that runs both functions my_squares and my_join"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")