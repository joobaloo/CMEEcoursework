#!/usr/bin/env python3
""" script containg buggyfunc function that required debugging """

def buggyfunc(x):
    """ function that was used to illustrate debugging in python"""
    y = x
    for i in range(x):
        try:
            y = y-1
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work;{x =}; {y =}")
        else:
            print(f"OK; {x = }; {y = }, {z = };")
    return z

buggyfunc(20)