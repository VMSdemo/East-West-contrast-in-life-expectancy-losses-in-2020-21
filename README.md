# East-West-contrast-in-life-expectancy-losses-in-2020-21

Additional materials for the study „ East-West mortality disparities during the COVID-19 pandemic widen the historical longevity divide in Europe ” by Vladimir M. Shkolnikov, Sergey Timonin, Dmitry Jdanov, Nazrul Islam, and David A. Leon


=====================================================================

====== Figure and table data
This folder provides data and calculations used by all tables and figures in the main text and

the supplementary material


=====================================================================

====== Data and scripts

== LE losses in R

This folder provides R script together with input and output data files.  

R script: e0-65e0-e65-l65-CI-from-ex_ci-vs-csv3.R

The script calculates the baseline (predicted) values of the life expectancy at ages 0 and 65 and the probability of dying between ages 15 and 65 in 2020 or 2021 and the 95% confidence limits for these quantities from the predicted age-specific death rates and their standard errors. Runs 2000 statistical simulations.

More details are given in the text of the paper. 

Input data files: ex_ci2005_2020-vs3.csv,  ex_ci2005_2021-vs3.csv

Output data files: e0-e065-e65-l65-ci-2020-3.csv,  e0-e065-e65-l65-ci-2021-3.csv



== Weekly excess deaths in Stata

This folder provides Stata do-file together with input and output data files. 

Stata do-file: Analysis-weeks-East-West-stdp-FIN1.do



Input data file: stmf-21-Oct-2022-vs-plus-RUS2021.csv

Output log-file: Mort-excess-weeks-cntrs.log

== Regression analysis of factors in Stata
Stata do-file: Analysis-final-24-05-23.do

Input data file: LEloss-factors.dta

Output log-file: Analysis-LEloss-Factors-24-05-2023.log

