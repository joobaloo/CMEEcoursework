# Author: Jooyoung Ser
# Script: apply2.R
# Description: This script demonstrates the apply function using another function
# Date: November 2022

SomeOperation <- function(v) { # (What does this function do?)
  if (sum(v) > 0) { #note that sum(v) is a single (scalar) value
    return (v * 100)
  } else { 
    return (v)
  }
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))