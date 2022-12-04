# Author: Jooyoung Ser
# Script: modelselection.R
# Description: This script contains the model selection approaches and plotting for the CMEE miniproject
# Date: December 22

rm(list = ls()) #clear workspace

#loading packages
library(ggplot2)
library(dplyr)
library(wesanderson) 
library(ggpubr)

##### AIC MODEL SELECTION #####

aicvalues <- read.csv("../results/lm_aic_results.csv")
aicvalues<- subset(aicvalues, select = -c(1, 2))
aicvalues[is.na(aicvalues) | aicvalues == "Inf" | aicvalues == "-Inf"] <- NA

logistic <- read.csv("../results/best_logistic_parameters.csv")
logistic[is.na(logistic) | logistic == "Inf" | logistic == "-Inf"] <- NA
gompertz <- read.csv("../results/best_gompertz_parameters.csv")
gompertz[is.na(gompertz) | gompertz == "Inf" | gompertz == "-Inf"] <- NA

aicvaluesdf <- data.frame(subset = rep(1:285, 5),
                          model = c(rep('lm1', 285),
                                    rep('lm2', 285),
                                    rep('lm3', 285),
                                    rep('Logistic', 285),
                                    rep('Gompertz', 285)),
                          AIC = c(aicvalues$lm1_AIC,
                                  aicvalues$lm2_AIC,
                                  aicvalues$lm3_AIC,
                                  logistic$AIC,
                                  gompertz$AIC))

AIC_bestmodels <- data.frame(subset = c(1:285),
                          best_model = rep(0, 285),
                          AIC = rep(0,285))

for (i in 1:285) {
  # subset out by ID:
  d <- aicvaluesdf[which(aicvaluesdf$subset == i),] 
  
  # rank AICs in order of lowest to highest:
  a <- order(d$AIC)
  ordered <- d$AIC[a]
  
  # if the difference between smallest and next smallest is < 2, terminate:
  if (isTRUE((ordered[2] - ordered[1]) < 2)) { 
    next
  }
  
  # otherwise, select the row with the lowest AIC
  else { 
    
    d_m <- d[which(d$AIC == ordered[1]),]
    
    # fill column in models_best with the details of this best model
    try(AIC_bestmodels[i, "AIC"] <- d_m$AIC, silent = TRUE) 
    try(AIC_bestmodels[i, "best_model"] <- as.character(d_m$model), silent = TRUE)
  }
}

AIC_bestmodels$best_model[AIC_bestmodels$best_model==0] <- NA

##### BIC MODEL SELECTION #####

bicvalues <- read.csv("../results/lm_bic_results.csv")
bicvalues<- subset(bicvalues, select = -c(1, 2))
bicvalues[is.na(bicvalues) | bicvalues == "Inf" | bicvalues == "-Inf"] <- NA

bicvaluesdf <- data.frame(subset = rep(1:285, 5),
                          model = c(rep('lm1', 285), rep('lm2', 285), rep('lm3', 285), rep('Logistic', 285), rep('Gompertz', 285)),
                          BIC = c(bicvalues$lm1_BIC, bicvalues$lm2_BIC, bicvalues$lm3_BIC, logistic$BIC, gompertz$BIC))

BIC_bestmodels <- data.frame(subset = c(1:285),
                         best_model = rep(0, 285),
                         BIC = rep(0,285))

for (i in 1:285) {
  # subset out by ID:
  d <- bicvaluesdf[which(bicvaluesdf$subset == i),] 
  
  # rank AICs in order of lowest to highest:
  a <- order(d$BIC)
  ordered <- d$BIC[a]
  
  # if the difference between smallest and next smallest is < 2, terminate:
  if (isTRUE((ordered[2] - ordered[1]) < 2)) { 
    next
  }
  
  # otherwise, select the row with the lowest AIC
  else { 
    
    d_m <- d[which(d$BIC == ordered[1]),]
    
    # fill column in models_best with the details of this best model
    try(BIC_bestmodels[i, "AIC"] <- d_m$BIC, silent = TRUE) 
    try(BIC_bestmodels[i, "best_model"] <- as.character(d_m$model), silent = TRUE)
  }
  
}

BIC_bestmodels$best_model[BIC_bestmodels$best_model==0] <- NA


##### plotting results of model selection #######
AIC <- table(AIC_bestmodels$best_model)
BIC <- table(BIC_bestmodels$best_model)

AIC <- subset(AIC, select = (-c(1)))
BIC <- subset(BIC, select = (-c(1)))

comp_data <- merge(AIC, BIC, by = "Var1")
names(comp_data) <- c("model", "AIC", "BIC")

aic_plot <- ggplot(data = comp_data, aes(x = model, y = AIC, fill = model)) +
  theme_classic() +
  scale_fill_manual(values=wes_palette(n=5, name= "Darjeeling1")) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  xlab("AIC")

bic_plot <- ggplot(data = comp_data, aes(x = model, y = BIC, fill = model)) +
  theme_classic() +
  scale_fill_manual(values=wes_palette(n=5, name= "Darjeeling1")) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  xlab("BIC")

bothplots <- ggarrange(aic_plot + rremove("ylab"),
                       bic_plot + rremove("ylab"),
                       nrow = 1, ncol = 2)
bothplots
fig.1 <- annotate_figure(bothplots,
                         top = text_grob("Comparison of Successfully Fit Models"),
                         left = text_grob("Frequency", rot = 90, vjust = 1), 
                         bottom = text_grob("Mathematical Models"))

#saving figure
png(file = "../results/fig_1.png")
fig.1
dev.off()


