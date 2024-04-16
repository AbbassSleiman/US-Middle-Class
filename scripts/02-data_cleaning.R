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

#### Read data ####
raw_incarceration_data <- 
  read_csv("data/raw_data/incarceration-rates-by-country-2024.csv")

raw_crime_data <-
  read_csv("data/raw_data/crime-rate-by-country-2024.csv")

raw_education_data <-
  read_csv("data/raw_data/education-rankings-by-country-2024.csv")

raw_poverty_data <-
  read_csv("data/raw_data/poverty-rate-by-country-2024.csv")

raw_unemployment_data <-
  read_csv("data/raw_data/unemployment-by-country-2024.csv")

#### Merge data ####
raw_merged_data <- inner_join(raw_incarceration_data, raw_crime_data, by = "country") |>
  inner_join(raw_education_data, by = "country") |>
  inner_join(raw_poverty_data, by = "country") |>
  inner_join(raw_unemployment_data, by = "country")

#### Clean data ####
cleaned_data <-
  raw_merged_data |>
  janitor::clean_names() |>
  rename(
    incarceration_rate = incarceration_rates_by_country_rate_per100k,
    poverty_rate = poverty_rate_value,
    crime_rate = crime_rate_by_country_crime_index,
    education_rank = education_rankings_by_country_wt20rank2024,
    unemployment_rate = unemployment_rate_world_bank
  )

# Define the decile boundaries
decile_boundaries <- c(1, 16, 28, 41, 58, 78, 101, 119, 139, 175, 198)

# Create a new column in the dataset to store the education rank categories
cleaned_data <- cleaned_data |>
  mutate(education_category = cut(education_rank, breaks = decile_boundaries, 
                                  labels = c("1-16", "17-28", "29-41", "42-58", 
                                             "59-78", "79-101", "102-119", 
                                             "120-139", "140-175", "176-198"))) |>
  select(
    country,
    incarceration_rate,
    poverty_rate,
    crime_rate,
    unemployment_rate,
    education_category
  ) |>
  na.omit()

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/incarceration_data.csv")
