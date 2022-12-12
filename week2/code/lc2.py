#!/usr/bin/env python3
""" practical script that demonstrates the use of list comprehensions """
# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
heavy_rain = [rainfall[i] for i in range(len(rainfall)) if rainfall[i][1] > 100]
print("The months that had rainfall over 100 mm are: ", heavy_rain)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 
light_rain = [rainfall[i][0] for i in range(len(rainfall)) if rainfall[i][1] < 50]
print("The months that had rainfall less than 50 mm are: ", light_rain)

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 
heavy_rain = []
for i in range(len(rainfall)):
    if rainfall[i][1] > 100:
        heavy_rain.append(rainfall[i])
print("The months that had rainfall over 100 mm are: ", heavy_rain)

light_rain = []
for i in range(len(rainfall)):
    if rainfall[i][1] < 50:
        light_rain.append(rainfall[i][0])
print(light_rain)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

