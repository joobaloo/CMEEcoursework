##add shebang
rm(list = ls()) #clear workspace

#loading packages
library(dplyr)

#load population data
data <- read.csv("../data/LogisticGrowthData.csv")
data <- subset(data, data$Time > 0) #removing rows with negative values
data <- subset(data, data$PopBio > 0 | data$PopBio_units != "N")

#split dataframe by unique combination + assign unique ID
splitdfs <- data %>% group_by(Medium, Temp, Species, Citation) %>% mutate(Unique_id = cur_group_id())
save(splitdfs, file = '../data/splitdfs.Rdata')




