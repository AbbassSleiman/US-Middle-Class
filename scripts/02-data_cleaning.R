#### Preamble ####
# Purpose: Merges the 5 datasets listing each of the variables into one dataset 
# and cleans them.
# Author: Abbass Sleiman
# Date: 15 April 2024
# Contact: abbass.sleiman@mail.utoronto.ca
# License: MIT
# Pre-requisites: Raw datasets must be downloaded as per the instructions in the 
# 01-download_data.R script.

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(here)
library(dplyr)
library(arrow)

#### Read data ####
raw_incarceration_data <- 
  read_csv("data/raw_data/incarceration-rates-by-country-2024.csv")

raw_violent_crime_data <-
  read_csv("data/raw_data/violent-crime-rates-by-country-2024.csv")

raw_education_data <-
  read_csv("data/raw_data/education-rankings-by-country-2024.csv")

raw_poverty_data <-
  read_csv("data/raw_data/poverty-rate-by-country-2024.csv")

raw_unemployment_data <-
  read_csv("data/raw_data/unemployment-by-country-2024.csv")

# Merge data
raw_merged_data <- inner_join(raw_incarceration_data, raw_violent_crime_data, by = "country") |>
  inner_join(raw_education_data, by = "country") |>
  inner_join(raw_poverty_data, by = "country") |>
  inner_join(raw_unemployment_data, by = "country")

# Clean data
cleaned_data <-
  raw_merged_data |>
  janitor::clean_names() |>
  rename(
    incarceration_rate = incarceration_rates_by_country_rate_per100k,
    poverty_rate = poverty_rate_value,
    education_rank = education_rankings_by_country_wt20rank2024,
    unemployment_rate = unemployment_rate_world_bank
  )

# Calculate violent crime rate per country
cleaned_data$violent_crime_rate <- rowSums(cleaned_data[, c("violent_crime_rates_by_country_hom_rate", 
                                                                  "violent_crime_rates_by_country_assault", 
                                                                  "violent_crime_rates_by_country_sex_violence",
                                                                  "violent_crime_rates_by_country_kidnap",
                                                                  "violent_crime_rates_by_country_robbery")], na.rm = TRUE)

# Define the decile boundaries
decile_boundaries <- c(1, 19, 34, 52, 71, 92, 110, 125, 147, 175, 198)

# Create a new column in the dataset to store the education rank categories
cleaned_data <- cleaned_data |>
  mutate(education_category = cut(education_rank, breaks = decile_boundaries, 
                                  labels = c("1-19", "20-34", "35-52", "53-71", 
                                             "72-92", "93-110", "111-125", 
                                             "126-147", "148-175", "176-198"))) |>
  select(
    country,
    incarceration_rate,
    poverty_rate,
    unemployment_rate,
    education_category,
    violent_crime_rate
    ) |>
  na.omit()

# Convert education_category into a factor variable
cleaned_data <- cleaned_data |>
  mutate(education_category = factor(education_category))

#### Save data ####
write_parquet(x = cleaned_data, sink = "data/analysis_data/incarceration_data.parquet")
