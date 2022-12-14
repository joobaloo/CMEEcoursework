#!/usr/bin/env R

# Title: vectorize1.r
# Author: Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)
# Date: Nov 2022

# This script sums a matrix using a looping method and a vectorised method, then compares run time

#Create matrix
M <- matrix(runif(1000000),1000,1000)

#Function to sum elements line by line
SumAllElements <- function(M) {
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]) {
    for (j in 1:Dimensions[2]) {
      Tot <- Tot + M[i,j]
    }
  }
  return (Tot)
}

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))