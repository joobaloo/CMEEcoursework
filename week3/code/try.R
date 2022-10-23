doit <- function(x) {
  temp_x <- sample(x, replace = TRUE)
  if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique values!")
  }
}

#generating the population
set.seed(1345) 
popn <- rnorm(50)
hist(popn)

#lapply(1:15, function(i) doit(popn))

result <- lapply(1:15, function(i) try(doit(popn), FALSE))
#the FALSE modifier for the try command supresses any error messages
#but the results will catch the errors so can be insepcted later

class(result)
result

result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
  result[[i]] <- try(doit(popn), FALSE)
}

##experiment with trycatch##

