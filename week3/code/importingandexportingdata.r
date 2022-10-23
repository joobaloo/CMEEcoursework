trees <- read.csv("../data/trees.csv")
ls(pattern = "tr*")

##writing and saving files
write.csv(MyData, "../results/MyData.csv")
dir("../results/") # Check if it worked