## Author: Jooyoung Ser
# Script: break.R
# Description: This script demonstrates the break command in R
# Date: November 2022

#breaking out of loops
i <- 0 #Initialize i
    while (i < Inf) {
        if (i == 10) {
            break 
        } else { # Break out of the while loop!  
            cat("i equals " , i , " \n")
            i <- i + 1 # Update i
    }
}

for (i in 1:10) {
  if ((i %% 2) == 0) # check if the number is odd
    next # pass to next iteration of loop 
  print(i)
}