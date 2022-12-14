#!/usr/bin/env python3
""" script that explore variable scope """
i = 1
x = 0
for i in range(10):
    x += 1
print(x)
print(i)

i = 1
x = 0
def a_function(y):
    """ function that demonstrates global/local variables """
    x = 0
    for i in range(y):
        x += 1
    return x
x = a_function(10)
print(x)
print(i)
#both x and i are localised to the fucntion but x was updated in the workspace as it was returned unlike i

##GLOBAL VARIABLES##
_a_global = 10 #a global variable
if _a_global >= 5:
    _b_global = _a_global + 5

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():
    """ function that highlights the use of global varibales """
    _a_global = 4

    if _a_global == 4:
        _b_global = _a_global + 5

    _a_local = 3

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)
print("After calling a_function, outside the function, the value of _a_local is ", _a_local) #supposed 

_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    """ function that compares global and local variables """
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global now is", _a_global)

def a_function():
    """ function that shows how global and local variables behave differently"""
    _a_global = 10

    def _a_function2():
        """ nested function """
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)
    
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)