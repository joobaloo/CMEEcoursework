#!/usr/bin/env python3
""" script that demonstrates debugging using is_an_oak function"""
import csv
import sys
import doctest
import re


#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Fagus sylvatica') 
    False
    >>> is_an_oak('Quercus robur')
    True
    >>> is_an_oak("Quercuss")
    True
    """
    return name.lower().strip().startswith('quercus')

def main(argv): 
    """ function that calls above function using scripts in data directory"""
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ")
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)
    doctest.testmod()
    sys.exit(status)