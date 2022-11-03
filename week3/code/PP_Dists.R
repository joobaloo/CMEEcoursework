rm(list = ls()) #clear environment
df <- read.csv("../data/EcolArchives-E089-51-D1.csv") #read data set

df$Prey.mass[which(df$Prey.mass.unit=="mg")] <- df$Prey.mass[which(df$Prey.mass.unit=="mg")]/1000
df$Prey.mass.unit[which(df$Prey.mass.unit=="mg")] <- "g"

#load packages
require(dplyr)
require(ggplot2) 
require(ggpubr)

theme_set(theme_minimal()) #setting theme for plots

splitdfs <- group_split(df, Type.of.feeding.interaction)

  
## Figure 1: predator mass distributions

insect_pred <- ggplot(splitdfs[[1]], aes(x = log(Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Insectivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Predator mass (g)") +
  ylab("Frequency")


pisci_pred <-ggplot(splitdfs[[2]], aes(x = log(Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Piscivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Predator mass (g)") +
  ylab("Frequency")

plank_pred <- ggplot(splitdfs[[3]], aes(x = log(Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Planktivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Predator mass (g)") +
  ylab("Frequency")

pred_pred <- ggplot(splitdfs[[4]], aes(x = log(Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Predacious") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Predator mass (g)") +
  ylab("Frequency")

pred_pisci_pred <- ggplot(splitdfs[[5]], aes(x = log(Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Predacious/Piscivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Predator mass (g)") +
  ylab("Frequency")

allpreds <- ggarrange(insect_pred, pisci_pred, plank_pred, pred_pisci_pred, pred_pred)

pdf("../results/Pred_Subplots.pdf", paper = "a4")
annotate_figure(allpreds, top = "Predator Mass Distributions by Feeding Interaction Type")
dev.off()


## Figure 2: prey mass distributions

insect_prey <- ggplot(splitdfs[[1]], aes(x = log(Prey.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Insectivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey mass (g)") +
  ylab("Frequency")


pisci_prey <-ggplot(splitdfs[[2]], aes(x = log(Prey.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Piscivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey mass (g)") +
  ylab("Frequency")

plank_prey <- ggplot(splitdfs[[3]], aes(x = log(Prey.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Planktivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey mass (g)") +
  ylab("Frequency")

pred_prey <- ggplot(splitdfs[[4]], aes(x = log(Prey.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Predacious") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey mass (g)") +
  ylab("Frequency")

pred_pisci_prey <- ggplot(splitdfs[[5]], aes(x = log(Prey.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Predacious/Piscivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey mass (g)") +
  ylab("Frequency")

allpreys <- ggarrange(insect_prey, pisci_prey, plank_prey, pred_pisci_prey, pred_prey)

pdf("../results/Prey_Subplots.pdf", paper = "a4")
annotate_figure(allpreys, top = "Prey Mass Distributions by Feeding Interaction Type")
dev.off()

## Figure 3: ratio mass distributions

insect_rat <- ggplot(splitdfs[[1]], aes(x = log(Prey.mass/Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Insectivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey Predator Size Ratio (g)") +
  ylab("Frequency")


pisci_rat <-ggplot(splitdfs[[2]], aes(x = log(Prey.mass/Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Piscivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey Predator Size Ratio (g)") +
  ylab("Frequency")

plank_rat <- ggplot(splitdfs[[3]], aes(x = log(Prey.mass/Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Planktivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey Predator Size Ratio (g)") +
  ylab("Frequency")

pred_rat <- ggplot(splitdfs[[4]], aes(x = log(Prey.mass/Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Predacious") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey Predator Size Ratio (g)") +
  ylab("Frequency")

pred_pisci_rat <- ggplot(splitdfs[[5]], aes(x = log(Prey.mass/Predator.mass))) +
  geom_histogram(fill = "#69b3a2",
                 color = "#e9ecef",
                 alpha = 0.9) +
  ggtitle("Predacious/Piscivorous") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("log Prey Predator Size Ratio (g)") +
  ylab("Frequency")

allrats <- ggarrange(insect_rat, pisci_rat, plank_rat, pred_pisci_rat, pred_rat)

pdf("../results/SizeRatio_Subplots.pdf", paper = "a4")
annotate_figure(allrats, top = "Prey-Predator Size Ratio Distributions by Feeding Interaction Type")
dev.off()

#csv file
columns = c("Classification", "Feeding type", "Mean", "Median")
means_n_medians <- as.data.frame(matrix(nrow = 0, ncol = length(columns)))

for (feedingtype in splitdfs){
    predmean <- mean(log(feedingtype$Predator.mass))
    predmedian <- median(log(feedingtype$Predator.mass))
    predoutput <- c("Predator", feedingtype$Type.of.feeding.interaction[1], predmean, predmedian)
    means_n_medians <- rbind(means_n_medians, predoutput)
    
    preymean <- mean(log(feedingtype$Prey.mass))
    preymedian <- median(log(feedingtype$Prey.mass))
    preyoutput <- c("Prey", feedingtype$Type.of.feeding.interaction[1], preymean, preymedian)
    means_n_medians <- rbind(means_n_medians, preyoutput)
    
    ratmean <- mean(log(feedingtype$Prey.mass/feedingtype$Predator.mass))
    ratmedian <- median(log(feedingtype$Prey.mass/feedingtype$Predator.mass))
    ratoutput <- c("Size ratio", feedingtype$Type.of.feeding.interaction[1], ratmean, ratmedian)
    means_n_medians <- rbind(means_n_medians, ratoutput)
}

colnames(means_n_medians) <- columns

write_csv(means_n_medians, "../results/PP_results.csv")


