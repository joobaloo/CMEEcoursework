#!/usr/bin/env R

# Title: TAutoCorr.R
# Author: Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)
# Date: Nov 2022

# Script that calculates the autocorrelation of temperature between years. It then tests the significance of this using permutation testing.

#Clear environment
rm(list=ls())

# Setseed 
set.seed(1234)

#Load data
load("../data/KeyWestAnnualMeanTemperature.RData")

# New columns with neigbouring temperatures
previous.year <- ats$Temp[1:99]
next.year <- ats$Temp[2:100]

# Calculate correlation
observed.cor <- cor(previous.year, next.year)

# New column for shuffled temperatures
ats$shuffled <- NA
results <- data.frame()

#function to shuffle temperatures & years to randomly assign them to each other + conducting correlation analysis
permuation <- function(before, after, n) {
  for (i in 1:n){
    shuffled <-sample(before)
    output <- c(i, cor(shuffled, after))
    results <- rbind(results, output)
  }
  return(results)
}

# finding correlation coefficient of permutations
df <- permuation(previous.year, next.year, 10000)
colnames(df) <- c("Permutation", "Correlation")

#number of permutations with correlation coefficient above observed correlation
above <- subset(df, df$Correlation > observed.cor)

#loading package
library(ggplot2)
theme_set(theme_minimal())

#plotting histogram
plot <-ggplot(df, aes(x = Correlation)) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Observed Correlation Compared With Random Permutations") +
  xlab("Correlation Coefficient") +
  ylab("Frequency") +
  geom_vline(aes(xintercept = observed.cor , colour = "red"),
             linetype = "longdash",
             show.legend = FALSE) +
  annotate("text",
           x=0.35, 
           y=120, 
           label="Observed Correlation", 
           color = "red",
           angle = 90,
           size = 3)

print(plot)
#saving output file
pdf(file="../results/autocorr_histogram.pdf")
print(plot)
dev.off()
