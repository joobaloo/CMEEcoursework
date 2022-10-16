from xxlimited import foo


foodweb=[('a','b'),('a','c'),('b','c'),('c','c')]
foodweb
foodweb[0]
foodweb[0][0]
foodweb[0][0] = "bbb" #tuples are immutable!

#however you can change a whole pairing

foodweb[0] = ("bbb","ccc")
foodweb[0]

#tuples may be immutable, but you can append to them by first creating an "empty space" for the new item:
a = (1, 2, [])
a
a[2].append(1000)
a
a[2].append(1000)
a
a[2].append((100,10))
a

a = (1, 2, 3)
b = a + (4, 5, 6)
b

c = b[1:]
c

b = b[1:]
b

a = ("1", 2, True)
a

#adding a string to numerical tuple? you can do it! tuples can handle compound variables
x = (1, 2, 3, [])
x[3].append("string")
x