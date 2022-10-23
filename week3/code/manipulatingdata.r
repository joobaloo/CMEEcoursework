years <- 1990:2009
years

years <- 2009:1990
years

seq(1, 10, 0.5) #1 to 10 in interv alsof .5


#accessing parts of data structures: indicies and indexing
myvar <- c('a', 'b', 'c', 'd', 'e')
myvar[1] #show element in first position

#recycling - r will recylce the shorter vector to make a vector of the same length #nolinting
a <- c(1,5) + 2
a

x <- c(1,2); y <- c(5,3,9,2)
x;y

x + y

##strings and pasting
species.name <- "Quercus robur" #You can alo use single quotes
species.name

paste("Quercus", "robur")

paste("Quercus", "robur",sep = "") #Get rid of space

paste("Quercus", "robur",sep = ", ") #insert comma to separate

paste('Year is:', 1990:2000)