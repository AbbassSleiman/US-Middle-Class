#### Preamble ####
# Purpose: Conducts 4 tests to verify that the cleaned dataset works as expected.
# Each of the 4 tests is outlined below.
# Author: Abbass Sleiman
# Date: 16 April 2024
# Contact: abbass.sleiman@mail.utoronto.ca
# License: MIT
# Pre-requisites: This script requires the user to have downloaded the data as per
# the instructions outlined in "01-download_data.R", as well as run the script
# "02-data_cleaning.R" in order to have access to the finalized cleaned data.


#### Workspace setup ####
library(tidyverse)
library(here)

#### Read data ####
cleaned_data <- read_csv(here("data/analysis_data/incarceration_data.csv"))

#### Convert education variable into factor ####
cleaned_data <- cleaned_data |>
  mutate(education_category = factor(education_category))

#### Test Data ####
# Test 1: Check if all values are non-negative
test_non_negative <- all(cleaned_data$incarceration_rate >= 0) &&
  all(cleaned_data$poverty_rate >= 0) &&
  all(cleaned_data$violent_crime_rate >= 0) &&
  all(cleaned_data$unemployment_rate >= 0)

# Test 2: Check if there are 134 unique countries
test_num_countries <- length(unique(cleaned_data$country)) == 134

# Test 3: Check if there are exactly 10 unique categories in the education category
test_unique_categories <- length(unique(cleaned_data$education_category)) == 10

# Test 4: Check if each column is of the correct class
test_column_classes <- class(cleaned_data$country) == "character" &&
  class(cleaned_data$incarceration_rate) == "numeric" &&
  class(cleaned_data$poverty_rate) == "numeric" &&
  class(cleaned_data$violent_crime_rate) == "numeric" &&
  class(cleaned_data$unemployment_rate) == "numeric" &&
  class(cleaned_data$education_category) == "factor"

# Print test results
print(paste("Test 1 (All values are non-negative):", test_non_negative))
print(paste("Test 2 (There are 134 unique countries):", test_num_countries))
print(paste("Test 3 (There are exactly 10 unique categories in the education category):", test_unique_categories))
print(paste("Test 4 (Each column is of the correct class):", test_column_classes))

