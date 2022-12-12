## Author: Jooyoung Ser
# Script: florida.R
# Description:This script is used for the "is Florida getting warmer?" practical
# Date: November 2022

#clear workspace
rm(list=ls())

#load data
load("../data/KeyWestAnnualMeanTemperature.RData")

ls()
class(ats)
head(ats)
plot(ats)

#correlation of observed result
observerd.result<-cor(ats$Year, ats$Temp)
class(ats$Year)

ats$shuffled <- NA
results <- data.frame()

#hypothesis: the temp of florida is constant (not changing over the years)

#permutation funcion
permuation <- function(year, temp, n) {
  for (i in 1:n){
    ats$shuffled <-sample(ats$Year)
    output <- c(i, cor(ats$shuffled, temp))
    results = rbind(results, output)
  }
  return(results)
}

df <- permuation(ats$Year, ats$Temp, 1000)
colnames(df) <- c("run", "correlation")

colnames(df) <- c("Permutation", "Correlation")
library(ggplot2)
theme_set(theme_minimal())

#plotting
plot <-ggplot(df, aes(x = Correlation)) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Observed Correlation Compared With Random Permutations") +
  xlab("Correlation Coefficient") +
  ylab("Frequency") +
  geom_vline(aes(xintercept = 0.5331784 , colour = "red"),
             linetype = "longdash",
             show.legend = FALSE) +
  annotate("text",
           x=0.51, 
           y=25, 
           label="Observed Correlation", 
           color = "red",
           angle = 90,
           size = 3)
#saving plot to pdf
pdf(file="../results/florida_histogram.pdf")
plot
dev.off()
