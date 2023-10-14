# East-West-contrast-in-life-expectancy-losses-in-2020-21



Additional materials for the study „ East-West mortality disparities during the COVID-19 pandemic widen the historical longevity divide in Europe ” by Vladimir M. Shkolnikov, Sergey Timonin, Dmitry Jdanov, Nazrul Islam, and David A. Leon  

=====================================================================   

====== Figure and table data    

This folder provides data and calculations used by all tables and figures in the main text and the supplementary material

=====================================================================   

====== Data and scripts   

This folder provides all programs and the corresponding input and output data used in the study

== LE losses in R
This sub-folder contains an R script together with input and output data files.    

R script: e0-65e0-e65-l65-CI-from-ex_ci-vs-csv3.R     

Input data files: ex_ci2005_2020-vs3.csv, ex_ci2005_2021-vs3.csv   

Output data files: e0-e065-e65-l65-ci-2020-3.csv, e0-e065-e65-l65-ci-2021-3.csv   

    

== Weekly excess deaths in Stata
This sub-folder contains a Stata do-file together with input and output data files.
Stata do-file: Analysis-weeks-East-West-stdp-FIN1.do
The do-file runs calculations of the baseline (predicted) values of the crude death rates in 2020 and 2021 for listed populations. For the prediction, it uses a functional form with a quadratic trend and two sin-cosin harmonics. 
More details are given in the text of the study.
Input data file: stmf-21-Oct-2022-vs-plus-RUS2021.csv
Output log-file: Mort-excess-weeks-cntrs.log

== Regression analysis of factors
This sub-folder contains a Stata do-file together with input and output files.
Stata do-file: Analysis-final-24-05-23.do
The do-file runs checks on the applicability of linear OLS models. They include statistical tests of the normality of variables’ distributions, linearity, and heteroscedasticity (Breusch-Pagan/Cook-Weisberg test) of relationships between the life expectancy losses and each explanatory variable.
Input data file: LEloss-factors.dta
Output log-file: Analysis-LEloss-Factors-24-05-2023.log



