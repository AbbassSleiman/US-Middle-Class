#### Preamble ####
# Purpose: Simulates 196 nations with randomly assigned incarceration rates,
# poverty rates, crime rates, unemployment rates, and educational rankings. This
# script also runs 5 tests to ensure proper functionality of the simulated dataset.
# Author: Abbass Sleiman
# Date: 16 April 2024
# Contact: abbass.sleiman@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(9)

# Number of countries
num_countries <- 196

# Generate educational ranking (unique integer values from 1 to 196)
educational_ranking <- sample(1:196, num_countries)

# Generate random values for other variables

# Mean incarceration rate of 200 per 100k, with standard deviation of 50, rounded to 1 decimal place
incarceration_rate <- round(abs(rnorm(num_countries, mean = 200, sd = 50)), 1)  

# Mean poverty rate of 15%, with standard deviation of 5, rounded to 1 decimal place
poverty_rate <- round(abs(rnorm(num_countries, mean = 15, sd = 5)), 1)    

# Mean crime rate of 40 per 100k, with standard deviation of 20, rounded to 1 decimal place
crime_rate <- round(abs(rnorm(num_countries, mean = 40, sd = 20)), 1) 

# Mean unemployment rate of 8%, with standard deviation of 4, rounded to 1 decimal place
unemployment_rate <- round(abs(rnorm(num_countries, mean = 8, sd = 4)), 1)      

# Create dataset
simulated_data <- data.frame(
  Country = paste0("Country ", 1:num_countries),
  Incarceration_Rate = incarceration_rate,
  Poverty_Rate = poverty_rate,
  Crime_Rate = crime_rate,
  Unemployment_Rate = unemployment_rate,
  Educational_Ranking = educational_ranking
)

#### Test Data ####
# Test 1: Check if all values are non-negative
test_non_negative <- all(simulated_data$Incarceration_Rate >= 0) &&
  all(simulated_data$Poverty_Rate >= 0) &&
  all(simulated_data$Crime_Rate >= 0) &&
  all(simulated_data$Unemployment_Rate >= 0)

# Test 2: Check if there are 196 unique countries
test_num_countries <- length(unique(simulated_data$Country)) == 196

# Test 3: Check if there are no repeats in the educational ranking
test_unique_educational_ranking <- length(unique(simulated_data$Educational_Ranking)) == num_countries

# Test 4: Check if each column is of the correct class
test_column_classes <- class(simulated_data$Country) == "character" &&
  class(simulated_data$Incarceration_Rate) == "numeric" &&
  class(simulated_data$Poverty_Rate) == "numeric" &&
  class(simulated_data$Crime_Rate) == "numeric" &&
  class(simulated_data$Unemployment_Rate) == "numeric" &&
  class(simulated_data$Educational_Ranking) == "integer"

# Test 5: Check if each value is rounded to one decimal place
test_rounding <- all(round(simulated_data$Incarceration_Rate, 1) == simulated_data$Incarceration_Rate) &&
  all(round(simulated_data$Poverty_Rate, 1) == simulated_data$Poverty_Rate) &&
  all(round(simulated_data$Crime_Rate, 1) == simulated_data$Crime_Rate) &&
  all(round(simulated_data$Unemployment_Rate, 1) == simulated_data$Unemployment_Rate)

# Print test results
print(paste("Test 1 (All values are non-negative):", test_non_negative))
print(paste("Test 2 (There are 196 unique countries):", test_num_countries))
print(paste("Test 3 (There are no repeats in the educational ranking):", test_unique_educational_ranking))
print(paste("Test 4 (Each column is of the correct class):", test_column_classes))
print(paste("Test 5 (Each value is rounded to one decimal place):", test_rounding))



