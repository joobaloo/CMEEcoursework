# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

#loading trees.csv file
tree_data <- read.csv("../data/trees.csv")
treeheight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))
  
    return(height)
}
#adding tree height column
tree_data$Tree.Height.m <- 
  treeheight(tree_data$Angle.degrees, tree_data$Distance.m)

#saving new data frame
write.csv(tree_data, "../results/TreeHts.csv")
