# Author: Jooyoung Ser
# Script: PP_Regress.R
# Description: This script performs regression models and plots them with ggplot
# Date: November 2022

rm(list = ls()) #clear environment
df <- read.csv("../data/EcolArchives-E089-51-D1.csv") #read data set

#load packages
require(dplyr)
require(ggplot2) 
require(grid)
require(scales)

#convert mg into g
df$Prey.mass[which(df$Prey.mass.unit=="mg")] <- df$Prey.mass[which(df$Prey.mass.unit=="mg")]/1000
df$Prey.mass.unit[which(df$Prey.mass.unit=="mg")] <- "g"

plot <- ggplot(df, aes(x = log(Prey.mass), y = log(Predator.mass), colour = Predator.lifestage)) +
  geom_point(shape = 3) +
  geom_smooth(method = 'lm', se = TRUE, fullrange = TRUE, size = 0.4) +
  facet_grid(rows = vars(Type.of.feeding.interaction), space = "free_y") +
  theme(strip.text = element_text(size = 7)) +
  xlab("Prey Mass in grams") +
  ylab("Predator Mass in grams") +
  scale_x_continuous("Prey Mass in grams", labels = scales::scientific) +
  scale_y_continuous("Predator Mass in grams", labels = scales::scientific) +
  theme(legend.position = "bottom", legend.title = element_text(face = "bold"))


pdf("../results/PP_Regress.pdf", paper = "a4")
print(plot)
dev.off()

columns = c("Life stage", "Feeding type", "Slope", "Intercept")
regress_results <- as.data.frame(matrix(nrow = 0, ncol = length(columns)))

splitdfs <- group_split(df, Predator.lifestage)

for (lifestage in splitdfs){
  insectmodel <- lm(log(lifestage$Predator.mass) ~ log(lifestage$Prey.mass))
  insectcf <- coef(insectmodel)
  insectintercept <- insectcf[1]
  insectslope <- insectcf[2]
  insectoutput <- c(lifestage$Predator.lifestage[1], "insectivorous", insectslope, insectintercept)
  regress_results <- rbind(regress_results, insectoutput)
  
  piscimodel <- lm(log(lifestage$Predator.mass) ~ log(lifestage$Prey.mass))
  piscicf <- coef(piscimodel)
  pisciintercept <- piscicf[1]
  piscislope <- piscicf[2]
  piscioutput <- c(lifestage$Predator.lifestage[1], "piscivorous", piscislope, pisciintercept)
  regress_results <- rbind(regress_results, piscioutput)
  
  plankmodel <- lm(log(lifestage$Predator.mass) ~ log(lifestage$Prey.mass))
  plankcf <- coef(plankmodel)
  plankintercept <- plankcf[1]
  plankslope <- plankcf[2]
  plankoutput <- c(lifestage$Predator.lifestage[1], "planktivorous", plankslope, plankintercept)
  regress_results <- rbind(regress_results, plankoutput)
  
  predmodel <- lm(log(lifestage$Predator.mass) ~ log(lifestage$Prey.mass))
  predcf <- coef(predmodel)
  predintercept <- predcf[1]
  predslope <- predcf[2]
  predoutput <- c(lifestage$Predator.lifestage[1], "predacious", predslope, predintercept)
  regress_results <- rbind(regress_results, predoutput)
  
  prepimodel <- lm(log(lifestage$Predator.mass) ~ log(lifestage$Prey.mass))
  prepicf <- coef(prepimodel)
  prepiintercept <- prepicf[1]
  prepislope <- prepicf[2]
  prepioutput <- c(lifestage$Predator.lifestage[1], "predacious/piscivorous", prepislope, prepiintercept)
  regress_results <- rbind(regress_results, prepioutput)
} 

colnames(regress_results) <- columns


write.csv(regress_results, "../results/PP_Regress_Results.csv")
















