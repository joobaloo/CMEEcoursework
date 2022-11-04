mydata <- as.matrix(read.csv("../data/PoundHillData.csv", header  = FALSE))
class(mydata)
mymetadata <- read.csv("../data/PoundHillMetaData.csv", header  = TRUE, sep = ";")
class(mymetadata)

#making the blanks in the data 0
mydata[mydata == ""] = 0

  ##converting the data from wide to long format##
#prepping the data
mydata <- t(mydata) #transposing the data
head(mydata)

colnames(mydata)
tempdata <- as.data.frame(mydata[-1,], stringsAsFactors = F)
head(tempdata)

colnames(tempdata) <- mydata[1,] #assigning column names from original data
head(tempdata)

rownames(tempdata) <- NULL #getting rid of row names
head(tempdata)

#converting into long format using reshape package
require(reshape2)
mywrangleddata <- melt(tempdata, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
head(mywrangleddata); tail(mywrangleddata)

#assigning the correct data types to each column
mywrangleddata[, "Cultivation"] <- as.factor(mywrangleddata[, "Cultivation"])
mywrangleddata[, "Block"] <- as.factor(mywrangleddata[, "Block"])
mywrangleddata[, "Plot"] <- as.factor(mywrangleddata[, "Plot"])
mywrangleddata[, "Quadrat"] <- as.factor(mywrangleddata[, "Quadrat"])
mywrangleddata[, "Count"] <- as.integer(mywrangleddata[, "Count"])
str(mywrangleddata)

  ##data exploration##
require(tidyverse)

#converting the dataframe to a tibble
mywrangleddata <- dplyr::as_tibble(mywrangleddata) 
#the same as: mywrangleddata <- as_tibble(my wrangleddata)
mywrangleddata

glimpse(mywrangleddata) #same as str()
utils::View(mywrangleddata) #same as fix()
filter(mywrangleddata, Count>100) #like subset()
slice(mywrangleddata, 10:15) #look at a particular range of data rows

mywrangleddata %>%
  group_by(Species) %>%
    summarise(avg = mean(Count))
#same as aggregrate(mywrangleddata$Count,list(mywrangleddate$Species), FUN=mean)

