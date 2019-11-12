##############

####################################
# 0: Initial Setup
####################################

library(bbsBayes)



# ####################################
# # 1: Fetch Data
# ####################################
#
# # Fetch data from FTP site and save as a file
#  bbs_data <- fetch_bbs_data()
# yes

# ####################################
# # 2: Prepare Data
# ####################################

# Stratify the data
strat = "bbs_cws"
bbs_strat <- stratify(by = strat)
species = "Barn Swallow"
# Prepare data for JAGS.
# This includes subsetting based on species of interest,
# adding in zeros, and performing model-specific calculations
jags_data <- prepare_jags_data(strat_data = bbs_strat,
                               species_to_run = species,
                               min_max_route_years = 3,
                               #min_year = 2000,
                               model = "firstdiff")



####################################
# 3: Run JAGS model
####################################
modfl = "firstdiffalt.txt"

mod <- run_model(jags_data = jags_data,
                 n_burnin = 10000,
                 n_thin = 10,
                 n_iter=10000,
                 #n_adapt = 1000,
                 parallel = T,
                 model_file_path = modfl,
                 parameters_to_save = c("n","n2","obs","sdobs"))




save(list = c("mod",
              "jags_data",
              "species",
              "bbs_strat"),
     file = paste0("data/",species," jags_models.RData"))









