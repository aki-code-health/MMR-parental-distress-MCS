# Family-level psychological distress and risk of childhood MMR non-immunisation: a UK Millennium Cohort Study

## Overview
This repository contains Stata code for analysing the association between parental psychological distress and childhood MMR non-immunisation in the UK Millennium Cohort Study.

## Data
The dataset is not publicly available due to privacy restrictions.

## Software
Stata/SE 15.0 (StataCorp LLC, College Station, TX, USA)

## How to run
Run the following Stata do-files in order:

1. 1_Initial_settings_merge_MCS_sweep_1_2.do  
2. 2_Merged_longitudinal_MCS1_2_parental_interview_derived_variables.do  
3. 3_Editing_variable_restricting_sample_table1_complete_case.do  

**Main analysis:**  
4. 4.0_Main_results_multiple_imputation_effect_modification_interaction_test.do  

**Optional analyses:**  
- 4.1_Sensitivity_analysis_outcome_definition.do  
- 4.2_Supplement_analyses_reasons_non-immunisation.do  

## Reproducibility
All analyses were conducted using de-identified data.  
As the dataset is not publicly available, users will need to obtain access separately.  
File paths should be adapted to local environments.

## Author
Akihiro Oishi
