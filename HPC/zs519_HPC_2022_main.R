# CMEE 2022 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Jooyoung Ser"
preferred_name <- "Joo"
email <- "zs519@imperial.ac.uk"
username <- "zs519"

# Please remember *not* to clear the workspace here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community){
  length(unique(community))
}

# Question 2
init_community_max <- function(size){
  seq(1, size, 1)
}

# Question 3
init_community_min <- function(size){
  rep(1, size)
}

# Question 4
choose_two <- function(max_value){
  n1 <- sample(1:max_value, 1)
  repeat{
    n2 <- sample(1:max_value, 1)
    if (n1 != n2){
      break
    }
  }
  return(c(n1, n2))
}

# Question 5
neutral_step <- function(community){
  replace <- choose_two(length(community))
  new_community <- community[-replace[1]]
  return(append(new_community, community[replace[2]]))
}

# Question 6
neutral_generation <- function(community){
  generation <- length(community)*0.5
  if (generation %% 2 != 0){
    up_or_down <- sample(1:2, 1)
    if (up_or_down == 1){
      ceiling(generation)
    }
    else
    {
      floor(generation)
    }
  }
  for (i in 1:generation){
    community <- neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  result <- c(species_richness(community))
  for (i in 1:duration){
    current_community <- neutral_generation(community)
    output <- species_richness(current_community)
    result <- rbind(result, output)
  }
  return(result)
}

# Question 8
question_8 <- function() {
  community <- init_community_max(100)
  points <- neutral_time_series(community, 200)
  df <- data.frame(points = points, generations = seq(0,200))
  p <- ggplot(df, aes(x = generations, y = points)) +
    geom_line() +
    xlab("Generations") +
    ylab("Species Richness") +
    ggtitle("Neutral Modelling of Species Richness Across Generations")
  png(filename="question_8.png", width = 600, height = 400)
  # plot your graph here
  plot(p)
  Sys.sleep(0.1)
  dev.off()
  return("Species richness will always converge to one eventually. This is because each gap is filled by an exisiting species and there is no immigration")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  replace <- choose_two(length(community))
  new_community <- community[-replace[1]]
  rate <- sample(c(0,1), 1, prob = c(speciation_rate, 1-speciation_rate))
  if (rate == 0){
    repeat{
      random <- sample(1:10000000, 1)
      if (!(random %in% community)) {
        break
      }
    }
    return(append(new_community, random))
  }
  else {
    return(append(new_community, community[replace[2]]))
  }
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  generation <- length(community)*0.5
  if (generation %% 2 != 0){
    up_or_down <- sample(1:2, 1)
    if (up_or_down == 1){
      ceiling(generation)
    }
    else
    {
      floor(generation)
    }
  }
  for (i in 1:generation){
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community) 
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  result <- c(species_richness(community))
  for (i in 1:duration){
    current_community <- neutral_generation_speciation(community, speciation_rate)
    output <- species_richness(current_community)
    result <- rbind(result, output)
  }
  return(result)
}

# Question 12
question_12 <- function()  {
    min_community <- init_community_min(100)
    min_points <- neutral_time_series_speciation(min_community, 200, 0.1)
    max_community <- init_community_max(100)
    max_points <- neutral_time_series_speciation(max_community, 200, 0.1)
    df <- data.frame(min_points = min_points, max_points = max_points, generations = seq(0,200))
    p <- ggplot(df, aes(x = generations)) +
      geom_line(aes(y = min_points), color = "darkred") +
      geom_line(aes(y = max_points), color = "steelblue") +
      xlab("Generations") +
      ylab("Species Richness") +
      ggtitle("Neutral Modelling of Species Richness Across \n Generations With Speciation") +
      annotate("text", x = 50, y = 80, label = "Maximum", color = "steelblue") +
      annotate("text", x = 50, y = 13, label = "Minimum", color = "darkred")
    p
  
  
  png(filename="question_12.png", width = 600, height = 400)
  plot(p)
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 13
species_abundance <- function(community)  {
  as.numeric(sort(table(community), decreasing = T))
}

# Question 14
octaves <- function(abundance_vector) {
  tabulate(floor(log2(abundance_vector))+1)
}

# Question 15
sum_vect <- function(x, y) {
  if (length(x) - length(y) > 0){ #if y is shorter than x
    y <- c(y, rep(0, length(x) - length(y)))
    }
  if (length(y) - length(x) > 0){ #if x is shorter than 
    x <- c(x, rep(0, length(y) - length(x)))
    }
  sum <- x + y
  return(sum)
}

# Question 16 
question_16 <- function() {
  min_community <- init_community_min(100)
  max_community <- init_community_max(100)
  speciation_rate <- 0.2
  for (i in 1:200){
    min_community <- neutral_generation_speciation(min_community, speciation_rate)
    max_community <- neutral_generation_speciation(max_community, speciation_rate)    
  }
  
  min_octaves <- octaves(species_abundance(min_community))
  max_octaves <- octaves(species_abundance(max_community))
  
  for (j in 1:2000){
    min_community <- neutral_generation_speciation(min_community, speciation_rate)
    max_community <- neutral_generation_speciation(max_community, speciation_rate)
    if (j%%20 == 0){
      min_octaves <- sum_vect(min_octaves, octaves(species_abundance(min_community)))
      max_octaves <- sum_vect(max_octaves, octaves(species_abundance(max_community))) 
    }
    mean_min_octaves <- min_octaves/100
    mean_max_octaves <- max_octaves/100
  }
  df <- data.frame(octaves_length = seq(1, length(mean_max_octaves)),
                   min_values = mean_min_octaves,
                   max_values = mean_max_octaves)
  min_plot <- ggplot(df, aes(x = octaves_length, y = min_values)) +
    geom_bar(stat = "identity", fill = "darkred") +
    xlab("Abundance Class") +
    ylab("N of Species") +
    ggtitle("Neutral Model Simulation of Minimum Initial Diverisity")
  max_plot <- ggplot(df, aes(x = octaves_length, y = max_values)) +
    geom_bar(stat = "identity", fill = "cyan3") +
    xlab("Abundance Class") +
    ylab("N of Species") +
    ggtitle("Neutral Model Simulation of Maximum Initial Diverisity")
  
  png(filename="question_16_min.png", width = 600, height = 400)
  min_plot
  Sys.sleep(0.1)
  dev.off()
  
  png(filename="question_16_max.png", width = 600, height = 400)
  max_plot
  Sys.sleep(0.1)
  dev.off()
  
  return("The initial condition of the system does not matter as after the 'burn in' period, the communities tend towards the same octaves")
  
}

# Question 17
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
  start_time <- proc.time()
  community <- init_community_min(size)
  time_series <- species_richness(community)
  
  #burn in
  for (i in 1:burn_in_generations){
    community <- neutral_generation_speciation(community, speciation_rate)
    if (i %% interval_rich == 0){
      time_series <- c(time_series, species_richness(community))
    }
  }
  #rest of simulation
  iterations <- 0
  abundance_list <- list(octaves(species_abundance(community)))
  repeat{
    iterations = iterations + 1
    community <- neutral_generation_speciation(community, speciation_rate)
    if (iterations %% interval_oct == 0){
      abundance_list[[(iterations/interval_oct) + 1]] <- octaves(species_abundance(community))
    }
    total_time <- as.double((proc.time() - start_time)/60)[3]
    if (total_time >= wall_time)
      break
  }
  save(time_series, abundance_list, community, total_time, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on
# the cluster

# Question 20
process_neutral_cluster_results <- function(){
  abundance_sum_500 <- c()
  abundance_count_500 <- 0
  
  abundance_sum_1000 <- c()
  abundance_count_1000 <- 0
  
  abundance_sum_2500 <- c()
  abundance_count_2500 <- 0
  
  abundance_sum_5000 <- c()
  abundance_count_5000 <- 0
  
  for (i in 1:100){
    file = paste("zs519_results", i, ".rda", sep = "")
    tryCatch({
      load(file)
      if (size == 500) {
        abundance_count_500 <- abundance_count_500 + 1
        sum_500 <- c()
        for (j in 1:length(abundance_list)){
          sum_500 <- sum_vect(sum_500, abundance_list[[j]])
        }
        abundance_sum_500 <- sum_vect(abundance_sum_500, (sum_500/length(abundance_list)))
      }
      
      if (size == 1000) {
        abundance_count_1000 <- abundance_count_1000 + 1
        sum_1000 <- c()
        for (j in 1:length(abundance_list)){
          sum_1000 <- sum_vect(sum_1000, abundance_list[[j]])
        }
        abundance_sum_1000 <- sum_vect(abundance_sum_1000, (sum_1000/length(abundance_list)))
      }
      
      if (size == 2500) {
        abundance_count_2500 <- abundance_count_2500 + 1
        sum_2500 <- c()
        for (j in 1:length(abundance_list)){
          sum_2500 <- sum_vect(sum_2500, abundance_list[[j]])
        }
        abundance_sum_2500 <- sum_vect(abundance_sum_2500, (sum_2500/length(abundance_list)))
      }
      
      if (size == 5000) {
        abundance_count_5000 <- abundance_count_5000 + 1
        sum_5000 <- c()
        for (j in 1:length(abundance_list)){
          sum_5000 <- sum_vect(sum_5000, abundance_list[[j]])
        }
        abundance_sum_5000 <- sum_vect(abundance_sum_5000, (sum_5000/length(abundance_list)))
      }
      
    }, error = function(e){cat(conditionMessage(e))})
  }
  mean_500 <- abundance_sum_500/abundance_count_500
  mean_1000 <- abundance_sum_1000/abundance_count_1000
  mean_2500 <- abundance_sum_2500/abundance_count_2500
  mean_5000 <- abundance_sum_5000/abundance_count_5000

  combined_results <- list(mean_500, mean_1000, mean_2500, mean_5000)
  save(combined_results, file = "combined_results.rda")
}


plot_neutral_cluster_results <- function(){
    # load combined_results from your rda file
  load("combined_results.rda")
  df <- data.frame(octaves <- c(seq(1, length(combined_results[[1]])),
                                  seq(1, length(combined_results[[2]])),
                                  seq(1, length(combined_results[[3]])),
                                  seq(1, length(combined_results[[4]]))),
                   no_species <- c(combined_results[[1]], combined_results[[2]], combined_results[[3]], combined_results[[4]]),
                   size <- c(rep("500", length(combined_results[[1]])),
                             rep("1000", length(combined_results[[2]])),
                             rep("2500", length(combined_results[[3]])),
                             rep("5000", length(combined_results[[4]])))
                   )
  df$octaves <- factor(df$octaves, levels = unique(df$octaves))
  df$size <- factor(df$size, levels = unique(df$size))
  
  p <- ggplot(df, aes(x = octaves, y = no_species, fill = size)) +
    geom_bar(stat = "identity") +
    facet_grid(size ~., scales = "free") +
    xlab("Abundance class") +
    ylab("N of Species") +
    scale_fill_manual(name = "Initial Community Size", labels = c("500", "1000", "2500", "5000"), values = c("tomato1", "cyan4", "olivedrab", "maroon"))
  plot(p)
    png(filename="plot_neutral_cluster_results.png", width = 600, height = 400)
    # plot your graph here
    plot(p)
    Sys.sleep(0.1)
    dev.off()
    
    return(combined_results)
}

###### SECOND PART #####  


# Question 21
state_initialise_adult <- function(num_stages,initial_size){
  state <- c(rep(0, num_stages - 1), initial_size)
  return(state)
}

# Question 22
state_initialise_spread <- function(num_stages,initial_size){
  abundance <- initial_size/num_stages
  state <- c(rep(abundance, num_stages))
  if (initial_size %% num_stages != 0){
    abundance <- floor(initial_size/num_stages)
    state <- c(rep(abundance, num_stages))
    remainder <- initial_size %% num_stages
    remainder_vect <- c(rep(1, remainder), rep(0, num_stages-remainder))
    state <- state + remainder_vect
  }
  return(state)
}

# Question 23
deterministic_step <- function(state,projection_matrix){
  new_state <- projection_matrix %*% state
}


# Question 24 
deterministic_simulation <- function(initial_state,projection_matrix,simulation_length){
  population_size <- c(sum(initial_state))
  for (i in 1:simulation_length){
    initial_state <- deterministic_step(initial_state, projection_matrix)
    population_size <- c(population_size, sum(initial_state))
  }
  return(population_size)
}

#deterministic_simulation(condition1, projection_matrix, 10)

# Question 25
question_25 <- function(){
  condition1 <- state_initialise_adult(4, 100)
  condition2 <- state_initialise_spread(4, 100)
  
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
  df <- data.frame(time_series <- c(deterministic_simulation(condition1, projection_matrix, 24), 
                                    deterministic_simulation(condition2, projection_matrix, 24)),
                   condition <- c(rep("adult", 25), rep("spread", 25)),
                   simulation <- c(seq(1, 25), seq(1,25)))
  
  
  p <- ggplot(df, aes(x = simulation, y = time_series)) +
    geom_line(aes(color = condition)) +
    ylab("N of Individuals") +
    xlab("N of Simulations") +
    scale_color_manual(name = "Initial State", labels = c("Adult", "Spread"), values = c("darkred", "steelblue")) +
    ggtitle("Time Series of Deterministic Simulation with Different Initial States")
  png(filename="question_25.png", width = 600, height = 400)
  # plot your graph here
  plot(p)
  Sys.sleep(0.1)
  dev.off()
  
  return("Both initial conditions led to an increase in population size. The initial state where the entire population were adults increased in population size faster compared to the inital state that had an equal number of individuals in all life stages")
}

# Question 26
trinomial <- function(pool,probs) {
  if (probs[1] == 1){
    return(c(pool, 0, 0))
  }
  else {
    #event 1: staying in current life stage
    event_1 <- rbinom(1, pool, probs[1])
    
    #event 2: mature
    event_2 <- rbinom(1, pool - event_1, probs[2]/(1-probs[1]))
    
    #event 3: die
    event_3 <- pool - event_1 - event_2
    return(c(event_1, event_2, event_3))
  }
}



# Question 27
survival_maturation <- function(state,projection_matrix) {
  new_state <- c(rep(0, length(state)))
  for (i in 1:(length(state)-1)){
    current <- state[i]
    stay_prob <- projection_matrix[i, i]
    mature_prob <- projection_matrix[i+1, i]
    stage_progression <- trinomial(current, c(stay_prob, mature_prob))
    new_state[i]<- new_state[i] + stage_progression[1]
    new_state[(i+1)]<- new_state[(i+1)] + stage_progression[2]
  }
  if(projection_matrix[length(state), length(state)] == 1){
    new_state[length(state)] <- new_state[length(state)] + state[length(state)]
  }
  else{
    new_state[length(state)] <- new_state[length(state)] + rbinom(1, state[length(state)], projection_matrix[length(state), lengths(state)])
  }
  return(new_state)
}

# projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
#                               0.0, 0.4, 0.4, 0.0,
#                               0.0, 0.0, 0.7, 0.25,
#                               2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
# identity_mat <- matrix(c(1, 0, 0, 0,
#                           0, 1, 0, 0,
#                           0, 0, 1, 0,
#                           0, 0, 0, 1), nrow = 4, ncol = 4)
# 
# test_proj_mat <- matrix(c(0.4, 0.6, 0, 0,
#                           0.0, 0.3, 0.7, 0,
#                           0.0, 0, 0.9, 0.1,
#                           0, 0.0, 0, 1), nrow = 4, ncol = 4)
# survival_maturation(condition2, identity_mat)
# survival_maturation(condition2, projection_matrix)
# survival_maturation(condition2, test_proj_mat)
# survival_maturation(c(0,0,0,0), test_proj_mat)

# Question 28
random_draw <- function(probability_distribution) {
  for (i in 1:length(probability_distribution)){
    if (runif(1,0,1) < cumsum(probability_distribution[i])){break}
    else{next}
  }
  return(i)
}

# random_draw(c(0.3,0.7,1))

# Question 29
stochastic_recruitment <- function(projection_matrix,clutch_distribution){
  mean_clutch_size <- sum(clutch_distribution * 1:length(clutch_distribution))
  recruitment_prob <- projection_matrix[1,ncol(projection_matrix)] / mean_clutch_size
  return(recruitment_prob)
}

# stochastic_recruitment(projection_matrix, clutch_distribution)

# Question 30
# test_state <- c(2, 4, 6, 8)
# test_clutch_dist <- c(0.3, 0.7, 1)
offspring_calc <- function(state,clutch_distribution,recruitment_probability){
  no_adults <- state[length(state)]
  no_recruit_adults <- rbinom(1, no_adults, recruitment_probability)
  total_offspring <- 0
  if (no_recruit_adults > 0){
    for (i in 1:round(no_recruit_adults)){
      total_offspring <- total_offspring + random_draw(clutch_distribution)
    }
  }
  return(total_offspring)
}

# offspring_calc(condition2, clutch_distribution, 0.5)

# Question 31
stochastic_step <- function(state,projection_matrix,clutch_distribution,recruitment_probability){
  #surivial and maturation
  new_state<- survival_maturation(state, projection_matrix)
  #recruitment
  recruits <- offspring_calc(state, clutch_distribution, recruitment_probability)
  new_state[1] <- new_state[1] + recruits
  return(new_state)
}
# stochastic_step(condition2, projection_matrix, clutch_distribution, 23)

# Question 32
stochastic_simulation <- function(initial_state, projection_matrix, clutch_distribution, simulation_length){
  recruitment_probability <- stochastic_recruitment(projection_matrix, clutch_distribution)
  population_size <- rep(NA, simulation_length)
  state <- initial_state
  for (i in 1:simulation_length){
    if( round(sum(state)) > 0){
      state <- stochastic_step(state, projection_matrix, clutch_distribution, recruitment_probability)
      population_size[i] <- sum(state)
    }
    else {population_size[i] <- 0}
  }
  population_size <- c(sum(initial_state), population_size)
  return(population_size)
}

# stochastic_simulation(condition2, projection_matrix, clutch_distribution, 24)

# Question 33
question_33 <- function(){
  condition1 <- state_initialise_adult(4, 100)
  condition2 <- state_initialise_spread(4, 100)
  
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
  
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
  
  df <- data.frame(time_series <- c(stochastic_simulation(condition1, projection_matrix, clutch_distribution, 24), 
                                    stochastic_simulation(condition2, projection_matrix, clutch_distribution, 24)),
                   condition <- c(rep("adult", 25), rep("spread", 25)),
                   simulation <- c(seq(1, 25), seq(1,25)))
  
  
  p <- ggplot(df, aes(x = simulation, y = time_series)) +
    geom_line(aes(color = condition)) +
    xlab("N of Simulations") +
    ylab("N of Individuals") +
    scale_color_manual(name = "Initial State", labels = c("Adult", "Spread"), values = c("darkred", "steelblue")) +
    ggtitle("Time Series of Stochastic Simulation with Different Initial States")
  plot(p)
  png(filename="question_33.png", width = 600, height = 400)
  plot(p)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("The stochastic simulations do not produce smooth progression of the two populations unlike the deterministic simulations. This is because stochasticity has been introduced to the demographic traits of the population")
}

# Questions 34 and 35 involve writing code elsewhere to run your simulations on the cluster

# Question 36
question_36 <- function(){
  large_adult_extinct <- 0
  small_adult_extinct <- 0
  large_spread_extinct <- 0
  small_spread_extinct <- 0
  
  #large adult population
  for (i in 1:250){
    #load file
    file = paste("zs519_demographic_results", i, ".rda", sep = "")
    load(file)
    #empty vector
    if (output[length(output)] == 0){
      large_adult_extinct <- large_adult_extinct + 1
    } 
  }
  
  #small adult population
  for (i in 251:500){
    #load file
    file = paste("zs519_demographic_results", i, ".rda", sep = "")
    load(file)
    #empty vector
    if (output[length(output)] == 0){
      small_adult_extinct <- small_adult_extinct + 1
    }
  }
  
  #large spread population
  for (i in 501:750){
    #load file
    file = paste("zs519_demographic_results", i, ".rda", sep = "")
    load(file)
    if (output[length(output)] == 0){
      large_spread_extinct <- large_spread_extinct + 1
    }
  }
  
  #small spread population
  for (i in 751:1000){
    #load file
    file = paste("zs519_demographic_results", i, ".rda", sep = "")
    load(file)
    if (output[length(output)] == 0){
      small_spread_extinct <- small_spread_extinct + 1
    }
  }
  
  extinctions <- c(large_adult_extinct, small_adult_extinct, large_spread_extinct, small_spread_extinct)
  initial_conditions <- c("Adults, Large", "Adults, Small", "Spread, Large", "Spread, Small")
  df <- data.frame(extinctions, initial_conditions)
  p <- ggplot(df, aes(x = extinctions, y = initial_conditions)) +
    geom_bar(stat = "identity", color = "steelblue", fill = "white") +
    coord_flip() +
    ylab("Initial Conditions") +
    xlab("N of Extinctions") +
    ggtitle("Number of Extinction per Initial Condition of the Stochastic Simulations")
    

  png(filename="question_36.png", width = 600, height = 400)
  # plot your graph here
  plot(p)
  Sys.sleep(0.1)
  dev.off()
  
  return("Smaller populations were most likely to go extinct as there are less recruiting adults. In reality, this is because smaller populations are more susceptible to demographic and genetic events")
}

# Question 37
question_37 <- function(){
  
  #large spread
  large_spread_df <- data.frame(matrix(nrow = 0, ncol = 121))
  for (i in 501:750){
    #load file
    file = paste("zs519_demographic_results", i, ".rda", sep = "")
    load(file)
    large_spread_df <- rbind(large_spread_df, output)
  }
  
  large_spread_mean <- c()
  for (column in 1:ncol(large_spread_df)){
    large_spread_mean <- c(large_spread_mean, mean(large_spread_df[,column]))
  }
  
  #small spread
  small_spread_df <- data.frame(matrix(nrow = 0, ncol = 121))
  for (i in 751:1000){
    #load file
    file = paste("zs519_demographic_results", i, ".rda", sep = "")
    load(file)
    small_spread_df <- rbind(small_spread_df, output)
  }
  
  small_spread_mean <- c()
  for (column in 1:ncol(small_spread_df)){
    small_spread_mean <- c(small_spread_mean, mean(small_spread_df[,column]))
  }
  
  large_spread<- state_initialise_spread(4, 100)
  small_spread <- state_initialise_spread(4, 10)
  
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
  deter_large_spread <- deterministic_simulation(large_spread, projection_matrix, 120)
  deter_small_spread <- deterministic_simulation(small_spread, projection_matrix, 120)
                  
  large_df <- data.frame(population_size = c(large_spread_mean, deter_large_spread),
                         simulation = c(seq(1, 121), seq(1, 121)),
                         type = c(rep("Stochastic", 121), rep("Deterministic", 121)))
  
  large_p <- ggplot(large_df, aes(x = simulation, y = population_size)) +
    geom_line(aes(color = type)) +
    ylab("Population Size") +
    xlab("Time") +
    scale_color_manual(name = "Simulation Type", labels = c("Stochastic", "Determinstic"), values = c("darkred", "steelblue")) +
    ggtitle("Comparison of Stochastic and Deterministic Simulation of Population Size with Large Starting Population") +
    ylim(0, 2000)
  
  png(filename="question_37_small.png", width = 600, height = 400)
  # plot your graph for the small initial population size here
  plot(large_p)
  Sys.sleep(0.1)
  dev.off()
  
  small_df <- data.frame(population_size = c(small_spread_mean, deter_small_spread),
                         simulation = c(seq(1, 121), seq(1, 121)),
                         type = c(rep("Stochastic", 121), rep("Deterministic", 121)))
  
  small_p <- ggplot(large_df, aes(x = simulation, y = population_size)) +
    geom_line(aes(color = type)) +
    ylab("Population Size") +
    xlab("Time") +
    scale_color_manual(name = "Simulation Type", labels = c("Stochastic", "Determinstic"), values = c("darkred", "steelblue")) +
    ggtitle("Comparison of Stochastic and Deterministic Simulation of Population Size with Small Starting Population") +
    ylim(0, 2000)
  
  png(filename="question_37_large.png", width = 600, height = 400)
  # plot your graph for the large initial population size here
  plot(small_p)
  Sys.sleep(0.1)
  dev.off()
  
  return("It becomes less appropriate to approximate the 'average' behaviour of the stochastic system with a deterministic model when the sample size gets smaller. This is because the the results of a stochastic simulation of a small population size is unlikley to reflect representative behaviour.")
}


# Challenge questions - these are optional, substantially harder, and a maximum
# of 14% is available for doing them. 

# Challenge question A
Challenge_A <- function() {
  
  
  
  png(filename="Challenge_A_min.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  png(filename="Challenge_A_max.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question B
Challenge_B <- function() {
  
  
  
  png(filename="Challenge_B.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question C
Challenge_C <- function() {
  
  
  
  png(filename="Challenge_C.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
Challenge_D <- function() {
  
  
  
  png(filename="Challenge_D.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function(){
  
  
  
  png(filename="Challenge_E.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function(){
  
  
  
  png(filename="Challenge_F.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
}
  
