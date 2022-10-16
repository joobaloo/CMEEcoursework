def modify_list_1(some_list) :
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)

modify_list_1(my_list)

print('after, my_list =', my_list)
#original list remains the same even though it is changed inside the function, as you would expect (what happens in vegas stays in vegas)

def modify_list_2(some_list) :
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)
print('after, my_list =', my_list)
#now the original my_list is changed because i explicitly replaced it - this reinforces the fact that explicity rtuen statements are important

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) #an actual modification of the list
    print('changed to ', some_list)

my_list = [1, 2, 3]
print('before, my_list =', my_list)

modify_list_3(my_list)
print('after, my_list =', my_list)
#append function will actually change the original list object, but should still use return statement to be safe and be able to capture the output

