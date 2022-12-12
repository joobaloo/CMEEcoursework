#!/usr/bin/env python3
""" practial script that highlights dictionary data type in python """

from pprint import pprint
taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. OR, 'Chiroptera': {'Myotis
#  lucifugus'} ... etc

#### Your solution here #### 
taxa_dic = {}
for x, y in taxa:
        taxa_dic.setdefault(y,[]).append(x)
pprint(taxa_dic)

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
#### Your solution here ####
taxa_dic_lc = {x[1]:set([y[0] for y in taxa if y[1] == x[1]]) for x in taxa} 
pprint(taxa_dic_lc)