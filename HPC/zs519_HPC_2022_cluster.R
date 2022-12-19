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
if (iter >= 1 && iter <= 25) {
  size <- 500
}

if (iter > 25 &&iter <= 50) {
  size <- 1000
}

if (iter > 50 &&iter <= 75) {
  size <- 2500
}

if (iter > 75 &&iter <= 100) {
  size <- 5000
}

neutral_cluster_run(speciation_rate = 0.61,
                    size = size,
                    wall_time = 690,
                    interval_rich = 1,
                    interval_oct = size/10,
                    burn_in_generations = 8 * size,
                    output_file_name = paste("zs519_results", iter, ".rda", sep = ""))
