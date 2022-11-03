################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################
library(tidyverse)

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as_tibble(read_csv("../data/PoundHillData.csv", col_names = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read_csv2("../data/PoundHillMetaData.csv")

############# Inspect the dataset ###############
slice_head(MyData)
slice_tail(MyData)
glimpse(MyData) 


############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData)

############# Replace species absences with zeros ###############
replace_na(MyData, 0)

############# Convert raw matrix to data frame ###############
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
?pivot_wider()

MyWrangledData <- pivot_wider(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), names_from = "Species", values_from = "Count")

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############
