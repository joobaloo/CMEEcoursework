#!/usr/bin/env python3
""" practical script that emphasies use of list comprehensions """

from codecs import latin_1_encode

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 
latin_names = [birds[i][0] for i in range(len(birds))]
print("The latin names of the birds are: ", latin_names)

common_names = [birds[i][1] for i in range(len(birds))]
print("The common names of the birds are: ", common_names)

mass = [birds[i][2] for i in range(len(birds))]
print("The mean body mass of the birds are: ", mass)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
latin_names = []
for i in range(len(birds)):
    latin_names.append(birds[i][0])
print("The latin names of the birds are: ", latin_names)

common_names = []
for i in range(len(birds)):
    common_names.append(birds[i][1])
print("The common names of the birds are: ", common_names)

mass = []
for i in range(len(birds)):
    mass.append(birds[i][2])
print("The mean body mass of the birds are: ", mass)
# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 