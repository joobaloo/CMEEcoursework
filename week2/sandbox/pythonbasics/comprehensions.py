##LIST COMPREHENSIONS##
x = [i for i in range(10)]
print(x)
#above is the same as below:
x = []
for i in range(10):
    x.append(i)
print(x)

x = [i.lower() for i in ["LIST", "COMPRHENSIONS", "ARE", "COOL"]]
print(x)
#which is the same as:
x = ["LIST","COMPREHENSIONS","ARE","COOL"]
for i in range(len(x)): # explicit loop
    x[i] = x[i].lower()
print(x)

#nested loop
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flattened_matrix = []
for row in matrix:
    for n in row:
        flattened_matrix.append(n)
print(flattened_matrix)
#same as
flattened_matrix = [n for row in matrix for n in row]
print(flattened_matrix)

##SET COMPREHENSIONS##
words = (["These", "are", "some", "words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])
print(first_letters)

#same as:
first_letters = {w[0] for w in words}
print(first_letters)

