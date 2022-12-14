#!/usr/bin/env R

# Title: PP_Regress_loc.R
# Author: Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)
# Date: Nov 2022

# Script similar to PP_Regress.R, with no generated plots but csv file from info about type of feeding interaction, Life stage and location


rm(list=ls())

#required R packages
require(ggplot2)
require(plyr)

# Import data
MyData <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# Data frame: type, predator, slope, intercept, R2, fvalve, and pvalue in turn
PP_Regress_Results = data.frame() # empty dataframe for storation
for(i in unique(MyData$Predator.lifestage)){
  stage = subset(MyData, Predator.lifestage == i) # subset of each pred lifestage
  
  for(n in unique(stage$Type.of.feeding.interaction)){
    type = subset(stage, Type.of.feeding.interaction == n) # subset of feeding type
    
    for(j in unique(type$Location)){
    loc = subset(type, Location == j) # subset of location
    print(paste(loc$Predator.lifestage[1], loc$Type.of.feeding.interaction[1], loc$Location[1]))
    stats = summary(lm(log(Predator.mass)~log(Prey.mass), data = loc))
    if(is.null(stats$fstatistic[1])){ f = "NA"}
    else{f = as.numeric(stats$fstatistic[1])}
    temp = data.frame(n, i, j, stats$coefficients[2], stats$coefficients[1], stats$r.squared, f, stats$coefficients[8])
    PP_Regress_Results = rbind(PP_Regress_Results, temp) 
    }
  }
  
}

names(PP_Regress_Results) = c("Type.of.feeding.interaction"," Predator.lifestage","Location", "Regression.slope", "Regression.intercept", "R2", "F.value","p.value")  #header
write.csv(PP_Regress_Results, "../results/PP_Regress_loc_Results.csv") # csv result
