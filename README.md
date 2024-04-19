# US Incarceration Rate

## Overview

This repo contains the data, `R` scripts, `shiny` web app, and final `PDF` report used in the analysis of the United States' issue of mass incarceration through a comparative analysis of global trends in education, unemployment, crime, and poverty rates, and their respective impacts on incarceration. Employing a Bayesian multiple linear regression model, we find evidence to suggest that poverty and unemployment negatively correlate with incarceration rates, whereas violent crime rates positively correlate. We also identify nuances in the relationship between educational attainment and incarceration rates. These insights may offer valuable considerations for policy-making aimed at addressing mass incarceration in the United States.


## File Structure

The repo is structured as follows:

-   `data` contains the data sources used in analysis including the raw and cleaned data. The section `Raw Data` below explains how one could gain access to the raw datasets. Note that the shiny web app is also contained in this folder as the the app must be in the same location as the dataset in order to run when uploaded.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `models` contains fitted models. 
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, clean, and test the data. It also contains the script used to generate the model used in the paper.

## Raw Data

There were 5 raw datasets in total that were used in this paper, all of which can be publically accessed and downloaded from the following links:
- `incarceration-rates-by-country-2024.csv` can be downloaded at: https://worldpopulationreview.com/country-rankings/incarceration-rates-by-country.
- `poverty-rate-by-country-2024.csv` can be downloaded at: https://worldpopulationreview.com/country-rankings/poverty-rate-by-country.
- `violent-crime-rates-by-country-2024.csv` can be downloaded at: https://worldpopulationreview.com/country-rankings/violent-crime-rates-by-country.
- `unemployment-by-country-2024.csv` can be downloaded at: https://worldpopulationreview.com/country-rankings/violent-crime-rates-by-country.
- `education-rankings-by-country-2024.csv` can be downloaded at: https://worldpopulationreview.com/country-rankings/education-rankings-by-country.

Note that the data could not be automatically downloaded using a script as accessing the data requires the user to input their email when attempting to download. The raw data will be immediately emailed to the user as a result for use.

## Shiny Web App

The shiny web app associated with this paper is linked on the front page of the paper. Alternatively, one can access the shiny web app through the link: https://wklzec-abbass-sleiman.shinyapps.io/incarceration_rate/. 

The shiny web app contains an interactive graph whereby the user can select between the 4 independent variables explored in the paper and how they relate to a nation's incarceration rate. Moreover, with regards to the educational ranking category in particular, the user is able to select which categories they wish to see in the form of a box plot, allowing the user to view the median and overall distribution of incarceration rates across each educational ranking category. One note to make regarding the box plot in particular is that the individual data points above some of the boxes are effectively outliers with regards to their incarceration rates relative to the incarceration rates of nations in their particular ranking category.

## Parquet Usage

I acknowledge that the usage of a parquet would have been ideal as opposed to saving the analysis data as a csv. Unfortunately, due to a recent update, an error with writing files as a parquet prevented me from being able to save the data as a parquet in a timely manner.

## Statement on LLM usage

No auto-complete tools such as co-pilot were used in the course of this project. However, CHATGPT-3.5 was used to aid in the writing of this paper. The entire chat history can be found in `other/llm/usage.txt`
