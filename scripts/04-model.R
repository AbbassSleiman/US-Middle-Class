#### Preamble ####
# Purpose: Uses a Bayesian linear regression model to model and predict the effect
# of poverty rate, crime rate, educational ranking, and unemployment on incarceration
# rates.
# Author: Abbass Sleiman
# Date: 16 April 2024
# Contact: abbass.sleiman@mail.utoronto.ca
# License: MIT
# Pre-requisites: This script requires the user to have access to the cleaned 
# dataset which can be accessed by having downloaded the raw data as per the 
# instructions outlined in "01-download_data.R" and then having run the script
# "02-data_cleaning.R".

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
cleaned_data <- read_csv("data/analysis_data/incarceration_data.csv")

### Model data ####
incarceration_model <-
  stan_glm(
    formula = incarceration_rate ~ poverty_rate + crime_rate + educational_ranking + 
      unemployment_rate + crime_rate * poverty_rate,
    data = cleaned_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 9
  )


#### Save model ####
saveRDS(
  incarceration_model,
  file = here("models/incarceration_model.rds")
)


