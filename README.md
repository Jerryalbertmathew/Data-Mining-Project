# Data Mining Project Template

This repository contains the code for a small data mining project developed as part of the course:

**Data Access and Data Mining for Social Sciences**

University of Lucerne

Jerry Albert Mathew  
Course: Data Mining for the Social Sciences using R
Term: Spring 2026

## Project Goal

The goal of this project is to analyze how "Institutional and Economic Policy Uncertainty" impacts
the relationship between high-return-Nasdaq 100 and traditional safe haven-Gold.

The project should demonstrate:

- Financial data(Gold & NAS100) retrieval by tidyquant.
- Integration of economic policy uncertainty index.
- Using the Gemini 3 Flash API(Llm) to provide historical and political context for market crashes.
- A reproducible pipeline in R using tidyverse and httr2.


## Research Question

To what extent does high Economic Policy Uncertainty (EPU) cause a decoupling between Gold and
the Nas100, and what specific institutional events drive these shifts?


## Data Source

- Nas100 (^NDX) and Gold Futures (GC=F) via Yahoo Finance using tidyquant package.
- https://ai.google.dev/gemini-api/docs/api-key - Gemini API
- https://fred.stlouisfed.org/docs/api/fred/ - FRED API for Economic Policy Uncertainty Index


## Repository Structure

- /data    The results saved as CSV files.
- /plot    Friction plots and visualizations.
- /scripts  R scripts for data retrieval, processing, and analysis.
- /.gitignore  Git ignore file to exclude sensitive data(API keys)
- README.md  This file with project overview and instructions.


## Reproducibility

To reproduce this project:

Clone the repository: git clone [https://github.com/Jerryalbertmathew/Data-Mining-Project.git].
Ensure you have an API Key for Gemini and FRED.
Set your API key in your R environment: Sys.setenv(GEMINI_API_KEY = "your_key_here"). 

Install the required R packages: tidyquant, httr2, fredr, tidyverse,roll, ggrepel

Run the scripts in the following order:

01_data pull.R
02_data analysis.R
03_lowest correlation.R
04_llm explanation.R(not a success, but the code is there)
05_llm successful_explanation.R
06_Final report.R


## Notes

The script 04_llm explanation.R was an attempt to use the Gemini API to get explanations for market crashes,
but it did not yield successful results due to the mention of gemini models in the code and it can be bypassed by using the latest 
gemini.
