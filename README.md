# US Incarceration Rate

## Overview

This repo provides students with a foundation for their own projects associated with *Telling Stories with Data*. You do not need every aspect for every paper and you should delete aspects that you do not need.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Parquet Usage

I acknowledge that the usage of a parquet would have been ideal as opposed to saving the analysis data as a csv. Unfortunately, due to a recent update, an error with writing files as a parquet prevented me from being able to save the data as a parquet in a timely manner.

## Raw Data

The raw data can be publically accessed and downloaded from the following links:
- `...` can be downloaded at ...

Note that the data could not be automatically downloaded using a script as accessing the data requires the user to input their email when attempting to download. The raw data will be immediately emailed to the user as a result for use.

## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The abstract and introduction were written with the help of ChatHorse and the entire chat history is available in inputs/llms/usage.txt.

## Some checks

- [ ] Change the rproj file name so that it's not starter_folder.Rproj
- [ ] Change the README title so that it's not Starter folder
- [ ] Remove files that you're not using
- [ ] Update comments in R scripts
- [ ] Remove this checklist