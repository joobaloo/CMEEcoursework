#!/usr/bin/env R

# Title: get_TreeHeight.R
# Author details: Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (L.feng22@imperial.ac.uk)
# Date: Nov 2022
# Script and data info:
# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
# height = distance * tan(radians)
# Arguments: 1 or 0
# args: csv; degrees: the angle of elevation of tree; distance: the distance from base of tree
# OUTPUT
# The heights of the tree, same units as "distance"


rm(list = ls())

# Function: calculate tree heights
TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    return (height)
}

# Read data from commandline
args<-commandArgs(trailingOnly=TRUE)

# if no input file, exit directly
if (length(args) != 1) { 
  stop("One(just one) .csv file needed.", call.=F)
} else {
  TreeData <- read.csv(args)
}

TreeData <- read.csv(file = args[1])

# Add a new column and calculate the tree height 
TreeData$Tree.Height.m <- TreeHeight(TreeData$Angle.degrees, TreeData$Distance.m)

# Create a csv output 
write.csv(TreeData, paste("../results/", tools::file_path_sans_ext(basename(args)), "_treeheights_R.csv",sep = ""), row.names = F)

