#shebang

rm(list = ls())

#loading packages
library(minpack.lm)
library(dplyr)
library(stats)

#loading data
splitdfs <- load("../data/splitdfs.Rdata") #can't load data

### MODEL FUNCTIONS ###

#logistic model
logistic <- function(t, r, K, N0) {
  N0 * K * exp(r*t)/(K + N0 * (exp(r * t) -1))
}

#gompertz model
gompertz <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

######## CREATING RESULTS DATAFRAME ##########

results.df <- splitdfs %>% distinct(splitdfs$Unique_id, .keep_all = TRUE)
results.df <- results.df %>% arrange(Unique_id)
results.df <- subset(results.df, select = -c(1, 5, 6, 12))
listdfs <- group_split(splitdfs)
#names(results.df) <- c("ID","lm1_intercept", "lm1_slope", "lm1AIC", 
                       #"lm2_intecept", "lm2_slope", "lmAIC",
                       #"log_r", "log_N0", "log_K", "success")

### TESTING ###
test_linmodel <- lm(log(PopBio)~Time, data = listdfs[[1]])
AIC(test_linmodel)

test_logistic_model <- nlsLM(PopBio~logistic(Time, r, K, N0), start=list(K = max(listdfs[[1]]$PopBio), r = 0.01, N0 = min(listdfs[[1]]$PopBio)), data = listdfs[[1]])
coef(test_logistic_model)

test_gompertz <- nlsLM(LogN ~ gompertz(t = Time, r_max, K, N_0, t_lag), data = listdfs[[1]],
                      list(t_lag = listdfs[[1]]$Time[which.max(diff(diff(log(listdfs[[1]]$PopBio))))]),
                           r_max = 0.62,
                           N_0 = min(log(listdfs[[1]]$PopBio)),
                           K = max(log(listdfs[[1]]$PopBio)))

###pre-allocating columns because *vectorisation* ###
results.df$lm1_intercept <- NA
results.df$lm1_slope <- NA
results.df$lm1_AIC <- NA

results.df$lm2_intercept <- NA
results.df$lm2_slope <- NA
results.df$lm2_AIC <- NA

results.df$lm3_intercept <- NA
results.df$lm3_slope <- NA
results.df$lm3_AIC <- NA

results.df$logistic_K <- NA
results.df$logistic_r <- NA
results.df$logistic_N0 <- NA

#filling dataframe
for (i in 1:nrow(results.df)){
  #linear model 1
  tryCatch({
    linmodel <- lm(log(PopBio)~Time, data = listdfs[[i]])
    results.df$lm1_intercept[i] <- coef(linmodel)[1]
    results.df$lm1_slope[i] <- coef(linmodel)[2]
    results.df$lm1_AIC[i] <- AIC(linmodel)
  }, error = function(e){cat("Some linearmodel1 models don't fit data:",conditionMessage(e), "\n")})
  
  #quadratic linear model
  tryCatch({
    linmodel2 <- lm(log(PopBio)~Time, data = listdfs[[i]])
    results.df$lm2_intercept[i] <- coef(linmodel2)[1]
    results.df$lm2_slope[i] <- coef(linmodel2)[2]
    results.df$lm2_AIC[i] <- AIC(linmodel)
  }, error = function(e){cat("Some linearmodel2 models don't fit data:",conditionMessage(e), "\n")})
  
  #cubic linear model
  tryCatch({
    linmodel3 <- lm(log(PopBio)~Time, data = listdfs[[i]])
    results.df$lm3_intercept[i] <- coef(linmodel3)[1]
    results.df$lm3_slope[i] <- coef(linmodel3)[2]
    results.df$lm3_AIC[i] <- AIC(linmodel)
  }, error = function(e){cat("Some linearmodel3 models don't fit data:",conditionMessage(e), "\n")})
  
  tryCatch({
  logmodel <- nlsLM(PopBio~logistic(Time, r, K, N0), start=list(K = max(listdfs[[i]]$PopBio), r = 0.01, N0 = min(listdfs[[i]]$PopBio)), data = listdfs[[i]])
  results.df$logistic_K <- coef(logmodel)[1]
  results.df$logistic_r <- coef(logmodel)[2]
  results.df$logistic_N0 <- coef(logmodel)[3]
  }, error = function(e){cat("Some logistic growth models don't fit data:",conditionMessage(e), "\n")})


}   


###MODEL CALCULATION###

maxPopBio <- max(testmodel$PopBio) #parameters
minPopBio <- min(testmodel$PopBio)
logistic_model <- nlsLM(PopBio~logistic(Time, r, K, N0), start=list(K = maxPopBio, r = 0.01, N0 = minPopBio), data = testmodel)
pred.log <- predict(logistic_model, newdata = list(Time = newpoints))
pred.df <- data.frame(newpoints, pred.lin, pred.log)
names(pred.df) <- c("Time", "linear_points", "log_points")


newpoints <- seq(0, 14000, length = 100000)


pred.lin <- predict(linmodel, newdata = list(Time = newpoints))




##########LOOP MODEL FITTING##########

for (i in splitdfs){
  #defining models
  linmodel <- lm(log(PopBio)~Time, data = i)
  pred.lin <- predict(linmodel, newdata = list(Time = newpoints))
-  
  linmodel2 <- lm(log(PopBio)~poly(Time, 2), data = i)
  pred.lin2 <- predict(linmodel2, newdata = list(Time = newpoints))
  
  pred.log <- predict(logistic_model, newdata = list(Time = newpoints))
  logistic_model <- nlsLM(log(PopBio)~logistic(Time, r, K, N0), start=list(K =  max(i$PopBio), r = 0.01, N0 = min(i$PopBio)), data = i)
  
  pred.df <- data.frame(newpoints, pred.lin, pred.lin2, pred.log)
  names(pred.df) <- c("Time", "linear_points", "quadratic_linear_points", "logistic_points")
}

