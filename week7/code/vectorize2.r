#!/usr/bin/env R

# Title: vectorize1.2
# Author: Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)
# Date: Nov 2022

# Runs the stochastic Ricker equation with gaussian fluctuations

#clear workspace
rm(list = ls())

#stockrick function
stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
  }
 return(N)

}



#vectorized stockrick function
stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  
  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix
  
  N[1, ] <- p0
    
    for (yr in 2:numyears){ #for each pop, loop through the years
      
      N[yr, (1:length(p0))] <- N[yr-1, (1:length(p0))] * exp(r * (1 - N[yr - 1, (1:length(p0))] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
      
    
  }
  return(N)
  
}

#compare run times
print("Non Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))



