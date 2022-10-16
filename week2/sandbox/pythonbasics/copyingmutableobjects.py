a = [1, 2, 3]
b = a

a.append(4)

print(a)
print(b)

#b changed as well because b is a "pointer/reference" to a, not an actucal copy in memory

a = [1, 2, 3]
b = a[:] #this is a "shallow" copy; one level deep

a.append(4)
print(a)
print(b)

a = [[1, 2], [3, 4]]
b = a[:]
print(a)
print(b)

a[0][1] = 22
print(a)
print(b)

import copy
a = [[1, 2], [3, 4]]
b = copy.deepcopy(a)
a[0][1] = 22
print(a)
print(b)