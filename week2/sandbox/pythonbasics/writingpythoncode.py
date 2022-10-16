
from readline import write_history_file


x = 11

for i in range(x):
    if i > 3: #4 spaces or 2 tabs in this case
        print(i)

##LOOPS##
for i in range(10):
    print(i)

a = range(10)
a

for i in range(1, 6):
    print(i)

for i in range(2, 10, 2): #skip odd numbers
    print(i)

##ITERATOR VS ITERABLE##
my_iterable = [1, 2, 3]
type(my_iterable)

my_iterator = iter(my_iterable)
type(my_iterator)

next(my_iterator) #same as my_iterator._next_()
next(my_iterator)
next(my_iterator)
next(my_iterator)

##SOME LOOP EXAMPLES##
#for loop
for i in range(5):
    print(i)

my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)

total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

##FUNCTIONS##
def foo(x):
    x *= x #same as x = x*x
    print(x)
    return x

whos

foo(2)

def foo(x):
    x *= x
    print(x)
    return x
y = foo(2)
type(y)





