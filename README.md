# Family-level psychological distress and risk of childhood MMR non-immunisation: a UK Millennium Cohort Study

## Overview
This repository contains Stata code for analysing the association between parental psychological distress and childhood MMR non-immunisation in the UK Millennium Cohort Study.

## Data
The dataset is not publicly available due to privacy restrictions.

## Software
Stata/SE 15.0 (StataCorp LLC, College Station, TX, USA)

## How to run
Run the following Stata do-files in order:

1. 1_Merge_data_editing_variable_restricting_sample_table1_complete_case.do  

**Main analysis:**  
2. 2.0_Main_results_multiple_imputation_effect_modification_interaction_test.do  

**Optional analyses:**  
- 2.1_Sensitivity_analyses_outcome_definition.do  
- 2.2_Supplement_analyses_reasons_non-immunisation.do  

## Reproducibility
All analyses were conducted using de-identified data.  
As the dataset is not publicly available, users will need to obtain access separately.  
File paths should be adapted to local environments.

## Data availability
The data used in this study are from the UK Millennium Cohort Study (MCS) 
and are available from the UK Data Service.

Users must apply for access:
https://ukdataservice.ac.uk/

After downloading the data, please set your local data path in the do-file:
global data "your/local/path"

## Author
Akihiro Oishi

