#!/usr/bin/env python3

""" This prints species names for trees from an external CSV file and searches for Oak trees (Quercus spp.).
The Oak trees are then written to an output file in the results directory called JustOaksData.csv"""

__appname__ = 'oaks_debugme.py'
__author__ = 'Jooyoung Ser (ZS519@ic.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)'
__version__ = '0.0.1'

### Import ###
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
    """ Main function called by the script"""
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    csvwrite.writerow(["Genus", "Species"]) # add the header
    oaks = set()
    for row in taxa:
        if row[0] != "Genus" and is_an_oak(row[0]):
            print(row)
            print ("The genus is: ")
            print(row[0] + '\n')
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])
        elif row[0] != "Genus":
            print(row)
            print ("The genus is: ")
            print(row[0] + '\n')                
    return 0

    
if (__name__ == "__main__"):
    status = main(sys.argv)
    doctest.testmod()
    sys.exit(status)
