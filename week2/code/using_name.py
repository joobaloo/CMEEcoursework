#!/usr/bin/env python3
""" script that demonstrates using python scripts to import modules """

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is: " + __name__)