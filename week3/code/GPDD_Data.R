# Author: Jooyoung Ser
# Script: GPDD_Data.R
# Description: This script demonstrates the "maps" package
# Date : November 2022

#install maps package
#install.packages("maps")
library(maps)

#load data
load("../data/GPDDFiltered.RData")

#explore function
#?map

#plotting data onto world map
map()
points(gpdd, col = "green")

#Majority of the datapoints are Europe/Northern Hemisphere. This could lead to biased results as this area has been disproportionately over-represented