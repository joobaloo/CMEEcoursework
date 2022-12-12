#!/usr/bin/env python3

"""Script to demonstrate sys.argv in python"""

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))

##first variable is always the file name