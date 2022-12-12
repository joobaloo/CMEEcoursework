#!/usr/bin/env python3

#############################
# STORING OBJECTS
#############################
# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

f = open('../sandbox/testp.p','wb') ## note the b: accept binary files
""" saving dictionary using pickle """
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f = open('../sandbox//testp.p','rb')
""" loading data using open() """
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)