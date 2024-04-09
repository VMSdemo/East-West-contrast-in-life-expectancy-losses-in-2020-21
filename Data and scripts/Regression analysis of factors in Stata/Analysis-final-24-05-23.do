* Test for normality of variables
* ========================================================================================

sktest leloss21_m leloss21_f si_21 vac01_09 vac01_12 trustgov trustsci regenforc 
gen vac01_09x = vac01_09
sum vac01_09, detail
replace vac01_09x = 0.5*(r(p1)+r(p5)) if ccode=="BGR"
gen vac01_12x = vac01_12 
sum vac01_12, detail
replace vac01_12x = 0.5*(r(p1)+r(p5)) if ccode=="BGR"
sktest leloss21_m leloss21_f si_21 vac01_09x vac01_12x trustgov trustsci regenforc 

* Variables: correlations with each other
* ========================================================================================

pwcorr leloss21_m vac01_09x vac01_12x si_21 si_w35p trustgov trustsci regenforc, sig
pwcorr leloss21_f vac01_09x vac01_12x si_21 si_w35p trustgov trustsci regenforc, sig

pwcorr leloss21_m vac01_09x trustgov trustsci regenforc, sig 
pwcorr leloss21_f vac01_09x trustgov trustsci regenforc, sig 

* Test for normality of residuals
* ========================================================================================
regress leloss21_m vac01_09x
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_m vac01_12x
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_m si_21
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_m trustgov
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_m trustsci
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_m regenforc
predict res_std, rstandard
swilk res_std
drop res_std

regress leloss21_f vac01_09x
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_f vac01_12x
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_f si_21
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_f trustgov
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_f trustsci
predict res_std, rstandard
swilk res_std
drop res_std
regress leloss21_f regenforc
predict res_std, rstandard
swilk res_std
drop res_std

* Effects of the East-West group on the explanatory factors
* ========================================================================================

encode group, gen(x_group)

regress vac01_09 ib2.x_group
regress si_21    ib2.x_group
regress trustgov ib2.x_group 
regress trustsci ib2.x_group
regress regenforc ib2.x_group


* Associations between LE losses and vaccination including linearity and heterohedasticity
* ========================================================================================

regress leloss21_m vac01_09x
linktest
estat hettest 
regress leloss21_m vac01_09x, robust

regress leloss21_f vac01_09x
linktest
estat hettest 
regress leloss21_f vac01_09x, robust

* Associations between LE losses and stringency including linearity and heteroscedasticity
* ========================================================================================

regress leloss21_m si_21
linktest
estat hettest 
regress leloss21_m si_21, robust

regress leloss21_f si_21
linktest
estat hettest 
regress leloss21_f si_21, robust

* Associations between LE losses and trust in government incl linearity and heteroscedasticity
* ========================================================================================

regress leloss21_m trustgov
linktest
estat hettest 
regress leloss21_m trustgov, robust

regress leloss21_f trustgov
linktest
estat hettest 
regress leloss21_f trustgov, robust

* Associations between LE losses and trust in science incl linearity and heteroscedasticity
* ========================================================================================

regress leloss21_m trustsci
linktest
estat hettest 
regress leloss21_m trustsci, robust

regress leloss21_f trustsci
linktest
estat hettest 
regress leloss21_f trustsci, robust

* Associations between LE losses and regulations enforcement incl linearity and heteroscedasticity
* ========================================================================================

regress leloss21_m regenforc
linktest
estat hettest 
regress leloss21_m regenforc, robust

regress leloss21_f regenforc
linktest
estat hettest 
regress leloss21_f regenforc, robust



* Analysis of the East-West life expectancy gap and its attenuation due to factors
* ========================================================================================

regress leloss21_m ib2.x_group, robust

regress leloss21_m ib2.x_group vac01_09x, robust
regress leloss21_m ib2.x_group si_21, robust
regress leloss21_m ib2.x_group trustgov, robust
regress leloss21_m ib2.x_group trustsci, robust
regress leloss21_m ib2.x_group regenforc, robust

regress leloss21_m ib2.x_group vac01_09x trustgov, robust
regress leloss21_m ib2.x_group vac01_09x trustsci, robust
regress leloss21_m ib2.x_group vac01_09x regenforc, robust

regress leloss21_f ib2.x_group

regress leloss21_f ib2.x_group vac01_09x
regress leloss21_f ib2.x_group si_21
regress leloss21_f ib2.x_group trustgov, robust
regress leloss21_f ib2.x_group trustsci
regress leloss21_f ib2.x_group regenforc, robust

regress leloss21_f ib2.x_group vac01_09x trustgov, robust
regress leloss21_f ib2.x_group vac01_09x trustsci
regress leloss21_f ib2.x_group vac01_09x regenforc, robust

* Model-fit comparisons 
* ========================================================================================

regress leloss21_m ib2.x_group vac01_09x if regenforc!=.
est sto M1
fitstat
regress leloss21_m ib2.x_group vac01_09x regenforc
est sto M2
fitstat
lrtest M1 M2

regress leloss21_f ib2.x_group vac01_09x if regenforc!=.
est sto M1
fitstat
regress leloss21_f ib2.x_group vac01_09x regenforc
est sto M2
fitstat
lrtest M1 M2

regress leloss21_m ib2.x_group vac01_09x if trustgov!=.
est sto M1
fitstat
regress leloss21_m ib2.x_group vac01_09x trustgov
est sto M2
fitstat
lrtest M1 M2

regress leloss21_f ib2.x_group vac01_09x if trustgov!=.
est sto M1
fitstat
regress leloss21_f ib2.x_group vac01_09x trustgov
est sto M2
fitstat
lrtest M1 M2



