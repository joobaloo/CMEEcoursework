mydf <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(mydf) #check the size of the data frame you loaded

str(mydf)

require(tidyverse)
glimpse(mydf)

mydf$Type.of.feeding.interaction <- as.factor(mydf$Type.of.feeding.interaction)
mydf$Location <-as.factor(mydf$Location)
str(mydf)

#scatterplots
plot(mydf$Predator.mass, mydf$Prey.mass)
plot(log(mydf$Predator.mass), log(mydf$Prey.mass))
#log in r is natural log base e
plot(log10(mydf$Predator.mass), log10(mydf$Prey.mass))
plot(log10(mydf$Predator.mass), log10(mydf$Prey.mass), 
     pch=20, 
     xlab = "Predator Mass (g)", 
     ylab = "Prey Mass (g)") # Add labels

#histograms
hist(mydf$Predator.mass)

hist(log10(mydf$Predator.mass), 
     xlab = "log10(Predator Mass (g))", 
     ylab = "Count") # include labels

hist(log10(mydf$Predator.mass), 
     xlab = "log10(Predator Mass (g))", 
     ylab = "Count",
     col = "lightblue", border = "pink", #change border and bar colours
     breaks = 10) #editing bar width

hist(log10(mydf$Prey.mass), 
     xlab = "log10(Prey Mass (g))", 
     ylab = "Count",
     col = "pink", border = "lightblue",
     breaks = 10) #change border and bar colours

#subplots
par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log10(mydf$Predator.mass),
     xlab = "log10(Predator Mass (g))", ylab = "Count", col = "lightblue", border = "pink", 
     main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log10(mydf$Prey.mass), xlab="log10(Prey Mass (g))",ylab="Count", col = "lightgreen", border = "pink", main = 'prey')

#overlaying plots
hist(log10(mydf$Predator.mass),# Predator histogram
     breaks = 8,
     xlab="log10(Body Mass (g))", ylab="Count", 
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap") 
hist(log10(mydf$Prey.mass),
     breaks = 8,
     col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors


#boxplots
boxplot(log10(mydf$Predator.mass), 
        xlab = "Location", 
        ylab = "log10(Predator Mass)", 
        main = "Predator mass")

boxplot(log(mydf$Predator.mass) ~ mydf$Location, #the tilde tells R to categorise the analysis and plot by the factor "location"
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by location")

boxplot(log(mydf$Predator.mass) ~ mydf$Type.of.feeding.interaction,
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by feeding interaction type")

#combining plot types
par(fig=c(0,0.8,0,0.8)) # specify figure size as proportion
plot(log(mydf$Predator.mass),log(mydf$Prey.mass), xlab = "Predator Mass (g)", ylab = "Prey Mass (g)") # Add labels
par(fig=c(0,0.8,0.4,1), new=TRUE)
boxplot(log(mydf$Predator.mass), horizontal=TRUE, axes=FALSE)
par(fig=c(0.55,1,0,0.8),new=TRUE)
boxplot(log(mydf$Prey.mass), axes=FALSE)
mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)

#saving graphics
pdf("../results/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(mydf$Predator.mass), # Plot predator histogram (note 'rgb')
     xlab="Body Mass (g)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(mydf$Prey.mass), # Plot prey weights
     col = rgb(0, 0, 1, 0.5), 
     add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
dev.off()


##BEAUTIFUL GRAPHICS IN R##
require(ggplot2)
qplot(Prey.mass, Predator.mass, data = mydf)

qplot(log(Prey.mass), log(Predator.mass), data = mydf)

qplot(log(Prey.mass), log(Predator.mass), data = mydf,
      colour = Type.of.feeding.interaction)

#changing aspect ratio using the asp option
qplot(log(Prey.mass), log(Predator.mass), data = mydf, 
      colour = Type.of.feeding.interaction, asp = 1)

#shape instead of colour
qplot(log(Prey.mass), log(Predator.mass), data = mydf, 
      shape = Type.of.feeding.interaction, asp = 1)

#aesthetic mappings

