# CMEE 2022 HPC exercises R code pro forma
# For stochastic demographic model cluster run


rm(list=ls()) # good practice 

graphics.off()

source("/rds/general/user/zs519/home/zs519_HPC_2022_main.R")
#source("zs519_HPC_2022_main.R")

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

#testing locally
#iter <- 1

#setting random seed
set.seed(iter)

#community size
if (iter >= 1 && iter <= 250) {
  initial_state <- state_initialise_adult(4, 100)
}

if (iter > 250 &&iter <= 500) {
  intial_state <- state_initialise_adult(4, 10)
}

if (iter > 500 &&iter <= 750){
  initial_state <- state_initialise_spread(4, 100)
}

if (iter > 750 &&iter <= 1000) {
  initial_state <- state_initialise_spread(4, 10)
}

projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                              0.0, 0.4, 0.4, 0.0,
                              0.0, 0.0, 0.7, 0.25,
                              2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)

clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)


output <- stochastic_simulation(initial_state = initial_state,
                                projection_matrix = projection_matrix,
                                clutch_distribution = clutch_distribution,
                                simulation_length = 120)

save(output, file = paste("zs519_demographic_results", iter, ".rda", sep = ""))