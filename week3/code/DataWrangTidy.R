################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################
library(tidyverse)


############# Load the dataset ###############
# col_names = false because the raw data don't have real headers
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
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############


MyTidyWrangledData <- as.data.frame(TempData %>%
                                      pivot_longer(cols = (5:45),
                                    names_to = c("Species"),
                                    names_pattern = NULL))
colnames(MyTidyWrangledData)[6] <- "Count"
  
MyTidyWrangledData[, "Cultivation"] <- as.factor(MyTidyWrangledData[, "Cultivation"])
MyTidyWrangledData[, "Block"] <- as.factor(MyTidyWrangledData[, "Block"])
MyTidyWrangledData[, "Plot"] <- as.factor(MyTidyWrangledData[, "Plot"])
MyTidyWrangledData[, "Quadrat"] <- as.factor(MyTidyWrangledData[, "Quadrat"])
MyTidyWrangledData[, "Count"] <- as.integer(MyTidyWrangledData[, "Count"])

slice_head(MyTidyWrangledData)
slice_tail(MyTidyWrangledData)
glimpse(MyTidyWrangledData) 

############# Exploring the data (extend the script below)  ###############
