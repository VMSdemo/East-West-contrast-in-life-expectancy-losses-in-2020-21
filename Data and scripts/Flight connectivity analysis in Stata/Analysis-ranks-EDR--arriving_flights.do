hist flights
hist x_etota_m

* ======= Analysis of quartile variables =================

pctile x_pct_flights=flights, nq(4)
xtile x_fightcats4=flights, cutpoints( x_pct_flights)

sort flights
list country region flights x_fightcats4, notrim

pctile x_pct_etot_m= x_etota_m , nq(4)
xtile x_etot_m_cats4=flights, cutpoints( x_pct_etot_m )

sort x_etota_m
list country region x_etota_m x_etot_m_cats4, notrim

spearman x_etot_m_cats4 x_fightcats4

ktau x_etot_m_cats4 x_fightcats4


* ======= Analysis of simple rankings ====================

egen x_rank_flights = group(flights)

sort flights
list country region flights x_rank_flights, notrim 

egen x_rank_EDR = group(x_etota_m)

sort x_etota_m
list country region x_etota_m x_rank_EDR, notrim

spearman  x_rank_EDR x_rank_flights
bootstrap r(rho), reps(1000) nodots : spearman x_rank_EDR x_rank_flights

ktau x_rank_EDR x_rank_flights





