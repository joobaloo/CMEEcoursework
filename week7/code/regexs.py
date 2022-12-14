#!/usr/bin/env python3

""" Demonstating regular expressions in python """

__appname__ = 'regexs.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

#importing module
import re

#example 1:
my_string = "a given string"
match = re.search(r'\s', my_string) #matches any whitespace characters
print(match) #tells us a match was fount
match.group() #tells us the match

#example 2:
match = re.search(r'\d', my_string) #matches numeric characters
print(match)

MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) # what pattern is this?

if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')    

match = re.search(r'2' , "it takes 2 to tango")
match.group()
match = re.search(r'\d' , "it takes 2 to tango")
match.group()
match = re.search(r'\d.*' , "it takes 2 to tango")
match.group()
match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group()
match = re.search(r'\s\w*$', 'once upon a time')
match.group()

#more compact syntax
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()
re.search(r'^\w*.*\s', 'once upon a time').group() 

re.search(r'^\w*.*?\s', 'once upon a time').group()
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()
re.search(r'\d*\.?\d*','1432.75+60.22i').group()

re.search(r'[AGTC]+', 'the sequence ATTCGT').group()
re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group()
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()