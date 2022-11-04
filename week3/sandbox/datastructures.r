##VECTORS##
a <- 5
is.vector(a)

v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def", "ghij")
v3 <- c(TRUE, TRUE, FALSE)

v1;v2;v3

#R vectors can only store data of a single type
v1 <- c(0.02, TRUE, 1)
v1

v1 <- c(0.02, "joobaloo", 1)
v1

#the c function coerces arguments that are of mixed types strings/text,real numbers,logical arguments to a common type #nolint

##MATRICES##
mat1 <- matrix(1:25, 5, 5)
mat1

mat1 <- matrix(1:25, 5, 5, byrow = TRUE)
# you can order the elements of a matrix by row instead of column (default)
mat1
dim(mat1) #get the size of the matrix

arr1 <- array(1:50, c(5, 5, 2)) #the second half?
arr1[, , 1]
print(arr1)

mat1[1, 1] <- "one"
mat1 #converted all elements to chr (string)

##DATA FRAMES##
col1 <- 1:10
col2 <- LETTERS[1:10]
col3 <- runif(10)

mydf <- data.frame(col1, col2, col3)
mydf

names(mydf) <- c("firstcolumn", "secondcolumn", "thirdcolumn")
mydf

mydf$firstcolumn #no spaces!
mydf[, 1] #same thing as above

##lists##
MyList <- list(species=c("Quercus robur","Fraxinus excelsior"), age=c(123, 84))
MyList
pop1<-list(species='Cancer magister',
           latitude=48.3,longitude=-123.1,
           startyr=1980,endyr=1985,
           pop=c(303,402,101,607,802,35))
pop1

##building lists
pop1<-list(lat=19,long=57,
           pop=c(100,101,99))
pop2<-list(lat=56,long=-120,
           pop=c(1,4,7,7,2,1,2))
pop3<-list(lat=32,long=-10,
           pop=c(12,11,2,1,14))
pops<-list(sp1=pop1,sp2=pop2,sp3=pop3)
pops

#check out species 1
pops$sp1
pops$sp1["pop"] # sp1's population sizes
pops[[2]]$lat #latitude of second species
pops[[3]]$pop[3]<-102 #change population of third species at third time step
pops