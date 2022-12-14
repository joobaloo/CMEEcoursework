#!/usr/bin/env python3

""" profiling in ipython """

__appname__ = 'profileme.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

#profiling in ipython: %run -p function_name
def my_squares(iters):
    """ function that produces a list of squared numbers"""
    out = []
    for i in range(iters):
        out.append(i ** 2) #exponentiation
    return out

def my_join(iters, string):
    """ function that joins an input string together separated by a comma"""
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """ function that runs both functions my_squares and my_join"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")