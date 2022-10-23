"""functions with conditionals created to undestand find-grained control over a function's operations"""

__appname__ = 'cfexercies1'
__author__ = 'joobaloo (zs519@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

"""Some functions exemplifying the use of conditionals"""

import sys

def foo_1(x):
    return x ** 0.5

def foo_2(x, y):
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > x:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    result = 1
    for i in range (1, x + 1):
        result = result * i
    return result

def foo_5(x):
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x):
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo_1(10))
    print(foo_2(15))
    print(foo_3(10))
    print(foo_4(15))
    print(foo_5(10))
    print(foo_6(15))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)