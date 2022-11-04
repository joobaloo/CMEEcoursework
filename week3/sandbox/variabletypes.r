v <- TRUE
v
class(v) #logical! same as boolean

v <- 3.2
class(v) #numeric

v <- 2L
class(v) #integer

v <- "A string"
class(v) #character

b <- NA #Not Available
class(b) #logical

#can you is.na function to check specific variable type
is.na(b)

b <- 0/0
b
is.nan(b) #Not a Number

b <- 5/0
b #inf = infinity

is.nan(b)

is.infinite(b)
is.finite(b)
is.finite(0/0)

##TYPE CONVERSIONS AND SPECIAL VALUES##
as.integer(3.1)
as.numeric(4)
as.roman(155)
as.character(155) c#same as converting to string in python
as.logical(5)
#R converts nonzero values to TRUE
as.logical(0)

##E NOTATION##
1E4
1e4
5e-2
1E4^2
1 / 3 / 1E8

##BOOLEAN ARGUMENTS##
a <- T
is.logical(a)