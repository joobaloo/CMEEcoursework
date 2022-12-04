# Author: Jooyoung Ser
# Script: modelfitting.R
# Description: This script contains the model fitting including parameter random sampling for the CMEE miniproject
# Date: December 22

rm(list = ls()) #clear workspace

#loading packages
library(minpack.lm)
library(dplyr)

#loading data
load("../data/splitdfs.Rdata")


### MODEL FUNCTIONS ###
#AIC function
aic_function <- function(model, data){
  rss <- sum(residuals(model)^2)
  n <- nrow(data)
  p <- length(coef(model))
  n + 2 + n * log((2 * pi) / n) + n * log(rss) + 2 * p
}

#BIC function
bic_function <- function(model, data){
  rss <- sum(residuals(model)^2)
  n <- nrow(data)
  p <- length(coef(model))
  n + 2 + n * log((2 * pi) / n) + n * log(rss) + p * log(n)
}


#logistic model
logistic <- function(t, r, K, N0) {
  N0 * K * exp(r*t)/(K + N0 * (exp(r * t) -1))
}

#gompertz model
gompertz <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1))
}

######## CREATING RESULTS DATAFRAME ##########

results.df <- splitdfs %>% distinct(splitdfs$Unique_id, .keep_all = TRUE)
results.df <- results.df %>% arrange(Unique_id)
results.df <- subset(results.df, select = -c(1, 2, 3, 5, 6, 12))

###pre-allocating columns because *vectorisation* ###
results.df$lm1_intercept <- NA
results.df$lm1_slope <- NA
results.df$lm1_AIC <- NA
results.df$lm1_BIC <- NA

results.df$lm2_intercept <- NA
results.df$lm2_slope <- NA
results.df$lm2_AIC <- NA
results.df$lm2_BIC <- NA

results.df$lm3_intercept <- NA
results.df$lm3_slope <- NA
results.df$lm3_AIC <- NA
results.df$lm3_BIC <- NA


###### FITTING THE MODELS ######
for (i in 1:nrow(results.df)){
  lm1_errors <- 0
  lm2_errors <- 0
  lm3_errors <- 0
  log_errors <- 0
  gomp_errors <- 0
  
  #linear model 1
  df <- subset(splitdfs, splitdfs$Unique_id == i)
  tryCatch({
    linmodel <- lm(log(PopBio)~Time, data = df)
    results.df$lm1_intercept[i] <- coef(linmodel)[1]
    results.df$lm1_slope[i] <- coef(linmodel)[2]
    results.df$lm1_AIC[i] <- aic_function(linmodel, df)
    results.df$lm1_BIC[i] <- bic_function(linmodel, df)
  }, error = function(e){lm1_errors <<- lm1_errors + 1})

  #quadratic linear model
  tryCatch({
    linmodel2 <- lm(log(PopBio)~poly(Time, 2), data = df)
    results.df$lm2_intercept[i] <- coef(linmodel2)[1]
    results.df$lm2_slope[i] <- coef(linmodel2)[2]
    results.df$lm2_AIC[i] <- aic_function(linmodel2, df)
    results.df$lm2_BIC[i] <- bic_function(linmodel2, df)
  }, error = function(e){lm2_errors <<- lm2_errors + 1})
  
  #cubic linear model
  tryCatch({
    linmodel3 <- lm(log(PopBio)~poly(Time, 3), data = df)
    results.df$lm3_intercept[i] <- coef(linmodel3)[1]
    results.df$lm3_slope[i] <- coef(linmodel3)[2]
    results.df$lm3_AIC[i] <- aic_function(linmodel3, df)
    results.df$lm3_BIC[i] <- bic_function(linmodel3, df)
  }, error = function(e){lm3_errors <<- lm3_errors + 1})
}

#####LOGISTIC GROWTH MODEL #######
print("Running random sampling of Logistic model parameters")
###### creating random parameters ######
logistic_results <- data.frame(matrix(ncol = 6, nrow = 0))
names(logistic_results) <- c("run", "ID", "log_start_K", "log_start_r", "log_start_N0")


for (i in 1:285){
  set.seed(i)
  df <- subset(splitdfs, splitdfs$Unique_id == i)
  parameterdf <- data.frame(matrix(ncol = 0, nrow = 100))
  parameterdf$run <- seq(1, 100)
  parameterdf$ID <- i
  parameterdf$log_start_K <- rnorm(100, mean = max(df$PopBio))
  parameterdf$log_start_r <-  runif(100, min = 10^-10, max = 10^-2)
  parameterdf$log_start_N0 <-  rnorm(100, mean = min(df$PopBio))
  logistic_results <<- rbind(logistic_results, parameterdf)
}


###### aic values for all random parameter models #####
logistic_results$AIC <- NA
logistic_results$BIC <- NA

for (i in 1:nrow(logistic_results)){
  df <- subset(splitdfs, splitdfs$Unique_id == logistic_results$ID[i])
  tryCatch({
    logmodel <- nlsLM(PopBio~logistic(Time, r, K, N0),
                      start=list(K = logistic_results$log_start_K[i],
                                 r = logistic_results$log_start_r[i],
                                 N0 =logistic_results$log_start_N0[i]), data = df)
    logistic_results$AIC[i] <- aic_function(logmodel, df)
    logistic_results$BIC[i] <- bic_function(logmodel, df)
  }
  ,error = function(e){log_errors <<- log_errors + 1
    #cat("Some logistic models don't fit data:",conditionMessage(e), "\n")
  })
}

###### finding best parameters for each dataset #######
na_logistic_results <- na.omit(logistic_results)
#n_distinct(na_logistic_results$ID)
logistic_parameters <- data.frame(matrix(ncol = 0, nrow = n_distinct(na_logistic_results$ID)))


for (i in 1:285){
  uniquedf <- subset(logistic_results, logistic_results$ID == i)
  newrow <- uniquedf[which.min(uniquedf$AIC),]
  logistic_parameters <- rbind(logistic_parameters, newrow)
}

write.csv(logistic_parameters, "../results/best_logistic_parameters.csv")

##### GOMPTERTZ MODEL #######
print("Running random sampling of Gompertz model parameters")
gompertz_results <- data.frame(matrix(ncol = 6, nrow = 0))
names(gompertz_results) <- c("run", "ID", "gomp_start_r", "gomp_start_K", "gomp_start_N0", "gomp_start_tlag")


for (i in 1:285){
  set.seed(i)
  df <- subset(splitdfs, splitdfs$Unique_id == i)
  parameterdf <- data.frame(matrix(ncol = 0, nrow = 100))
  parameterdf$run <- seq(1, 100)
  parameterdf$ID <- i
  parameterdf$gomp_start_r <-  runif(100, min = 10^-10, max = 10^-2)
  parameterdf$gomp_start_K <- rnorm(100, mean = max(log(df$PopBio)))
  parameterdf$gomp_start_N0 <- rnorm(100, mean = min(log(df$PopBio)))
  parameterdf$gomp_start_tlag <- rnorm(100, mean = df$Time[which.max(diff(diff(log(df$PopBio))))])
  gompertz_results <<- rbind(gompertz_results, parameterdf)
}


###### aic values for all random parameter models #####
gompertz_results$AIC <- NA
gompertz_results$BIC <- NA

for (i in 1:nrow(gompertz_results)){
  df <- subset(splitdfs, splitdfs$Unique_id == gompertz_results$ID[i])
  tryCatch({
    gompmodel <- nlsLM(log(PopBio) ~ gompertz(t = Time, r_max, K, N_0, t_lag),
                       list(t_lag= gompertz_results$gomp_start_tlag[i],
                            r_max= gompertz_results$gomp_start_r[i],
                            N_0 = gompertz_results$gomp_start_N0[i],
                            K = gompertz_results$gomp_start_K[i]), data = df)
    gompertz_results$AIC[i] <- aic_function(gompmodel, df)
    gompertz_results$BIC[i] <- bic_function(gompmodel, df)
  }
  ,error = function(e){gomp_errors <<-gomp_errors + 1
    #cat("Some Gompertz models don't fit data:",conditionMessage(e), "\n")
    })
}

###### finding best parameters for each dataset #######
na_gompertz_results <- na.omit(gompertz_results)
#n_distinct(na_gompertz_results$ID)
gompertz_parameters <- data.frame(matrix(ncol = 0, nrow = n_distinct(na_gompertz_results$ID)))


for (i in 1:285){
  uniquedf <- subset(gompertz_results, gompertz_results$ID == i)
  newrow <- uniquedf[which.min(uniquedf$AIC),]
  gompertz_parameters <- rbind(gompertz_parameters, newrow)
}

write.csv(gompertz_parameters, "../results/best_gompertz_parameters.csv")
#### AIC/BIC ####
aic.results.df <- subset(results.df, select = c(Unique_id, lm1_AIC, lm2_AIC, lm3_AIC))
bic.results.df <- subset(results.df, select = c(Unique_id, lm1_BIC, lm2_BIC, lm3_BIC))

write.csv(aic.results.df, "../results/lm_aic_results.csv")
write.csv(bic.results.df, "../results/lm_bic_results.csv")