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
library(modelsummary)

#### Read data ####
cleaned_data <- read_csv("data/analysis_data/incarceration_data.csv")

#### Convert education to a factor variable ####
cleaned_data <- cleaned_data |>
  mutate(education_category = factor(education_category))

#### Make the 176-198 the reference category ####
cleaned_data$education_category <- relevel(cleaned_data$education_category, ref = "176-198")

### Model data ####
incarceration_model <-
  stan_glm(
    formula = incarceration_rate ~ poverty_rate + violent_crime_rate + education_category  + 
      unemployment_rate + education_category * poverty_rate,
    data = cleaned_data,
    family = gaussian(),
    prior = c(
      # Prior specification for poverty_rate coefficient
      normal(location = 0, scale = 2.5, autoscale = TRUE),
      
      # Prior specification for crime_rate coefficient
      normal(location = 0, scale = 2.5, autoscale = TRUE),
      
      # Prior specification for education category coefficient
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 1-16
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 17-28
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 29-41
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 42-58
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 59-78
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 79-101
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 102-119
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 120-139
      normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for category 140-175
      
      # Prior specification for unemployment_rate coefficient
      normal(location = 0, scale = 2.5, autoscale = TRUE)
    ),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 9
  )


modelsummary(
  list(
    "Test" = incarceration_model
    ),
  fmt = 1
)

#### Save model ####
saveRDS(
  incarceration_model,
  file = here("models/incarceration_model.rds")
)


