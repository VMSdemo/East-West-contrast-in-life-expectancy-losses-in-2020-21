* ========== Weekly excess mortality for 28 European countries (except Lux and Ice) by groups EE (11 cntrs) WE (17 cntrs) ===================

* *** Entering stmf data (the first lines should be already deleted in STMF.csv)

* cd "C:\Working-Directory"  --- Define the working directory here or using Stata "File/Working directory" menu 

insheet using stmf-21-Oct-2022-vs-plus-RUS2021.csv

* log using Mort-excess-weeks-cntrs

* *** Creation of country-numbers
egen x_countryNr = group(countrycode) 

* *** Variable combining week and year
gen x_YW = round(year+week*0.01, 0.01)
format x_YW %6.2f

* Variable for year 
gen x_Y = year - 2005
gen x_Y2 = x_Y^2

* *** Variables for harminics
gen x_sin1 = sin(2*_pi*week/52)
gen x_sin2 = sin(2*_pi*week/26)
gen x_cos1 = cos(2*_pi*week/52)
gen x_cos2 = cos(2*_pi*week/26) 

di "*************************************************************************"
  di "REGION =  WEST"
  di "  "
  di "  "
  
* **** Loop across 17 WE countries  

foreach i of numlist 2 3 6 9/11 13/18 23 28/29 32 36  {
   
  quietly regress rtotal x_Y x_Y2 x_sin1 x_cos1 x_sin2 x_cos2 if week>=1&week<=52&year>=2005&year<=2019&sex=="b"&x_countryNr==`i'
  
  quietly predict x_rtotal_m if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly predict x_rtotal_d if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i', stdp
  
  quietly gen x_rtotal_m1 = x_rtotal_m - 1.96*x_rtotal_d if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly gen x_rtotal_m2 = x_rtotal_m + 1.96*x_rtotal_d if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  
  quietly gen x_Etotal_m =  rtotal - x_rtotal_m if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly gen x_Etotal_m2 = rtotal - x_rtotal_m1 if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly gen x_Etotal_m1 = rtotal - x_rtotal_m2 if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  
  quietly gen x_rtotal = rtotal*100000
  quietly replace x_rtotal_m =  x_rtotal_m * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_rtotal_m1 = x_rtotal_m1 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_rtotal_m2 = x_rtotal_m2 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_Etotal_m =  x_Etotal_m * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_Etotal_m1 = x_Etotal_m1 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_Etotal_m2 = x_Etotal_m2 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  
  list countrycode x_YW x_rtotal x_rtotal_m x_rtotal_m1 x_rtotal_m2 x_Etotal_m x_Etotal_m1 x_Etotal_m2 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i',     notrim

  quietly drop x_rtotal x_rtotal_m x_rtotal_m1 x_rtotal_m2 x_rtotal_d x_rtotal_m1 x_rtotal_m2 x_Etotal_m x_Etotal_m1 x_Etotal_m2
                                                     }

di "*************************************************************************"
  di "REGION =  EAST"
  di "  "
  di "  "
  
* **** Loop across 11 EE countries  

foreach i of numlist 4 8 12 19 20 25 27 31 33/35  {
   
  quietly regress rtotal x_Y x_Y2 x_sin1 x_cos1 x_sin2 x_cos2 if week>=1&week<=52&year>=2005&year<=2019&sex=="b"&x_countryNr==`i'
  
  quietly predict x_rtotal_m if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly predict x_rtotal_d if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i', stdp
  
  quietly gen x_rtotal_m1 = x_rtotal_m - 1.96*x_rtotal_d if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly gen x_rtotal_m2 = x_rtotal_m + 1.96*x_rtotal_d if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  
  quietly gen x_Etotal_m =  rtotal - x_rtotal_m if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly gen x_Etotal_m2 = rtotal - x_rtotal_m1 if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  quietly gen x_Etotal_m1 = rtotal - x_rtotal_m2 if week>=1&week<=52&year>=2005&year<=2021&sex=="b"&x_countryNr==`i'
  
  quietly gen x_rtotal = rtotal*100000
  quietly replace x_rtotal_m =  x_rtotal_m * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_rtotal_m1 = x_rtotal_m1 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_rtotal_m2 = x_rtotal_m2 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_Etotal_m =  x_Etotal_m * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_Etotal_m1 = x_Etotal_m1 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  quietly replace x_Etotal_m2 = x_Etotal_m2 * 100000 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i'
  
list countrycode year week x_rtotal x_rtotal_m x_rtotal_m1 x_rtotal_m2 if week>=1&week<=53&year>=2020&year<=2021&sex=="b"&x_countryNr==`i',     notrim

quietly drop x_rtotal x_rtotal_m x_rtotal_m1 x_rtotal_m2 x_rtotal_d x_rtotal_m1 x_rtotal_m2 x_Etotal_m x_Etotal_m1 x_Etotal_m2
                                                     }

log close
translate Mort-excess-weeks-cntrs.smcl Mort-excess-weeks-cntrs.log
												 



