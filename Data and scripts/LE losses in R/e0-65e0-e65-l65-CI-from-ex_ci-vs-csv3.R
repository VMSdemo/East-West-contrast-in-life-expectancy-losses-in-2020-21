# ========= Calculation of e0, e0-65, e65, l65, adjl65 =========================
# ========= with their 95%CIs from file ex_ci2005_2020-vs or 21-vs ============= 

# Function for computation of abridged life table

LTab <- function(mx, sex, popname) {
  Nx <- length(mx)   # number of ages
  
  Sexx <- rep(sex, Nx)  # Column specifying gender
  
  Popx <- rep(popname, Nx)   # Column specifying 
  
  x0 <- c(0,1)
  x1 <- numeric()
  for (i in 1:Nx-2) {x1[i] <- 5*i }
  x <- append(x0, x1)  # vector of ages
  
  nx0 <- c(1,4)
  nx1 <- rep(5, Nx-2)
  nx <- append(nx0, nx1)  # widths of age intervals
  
  if (sex=="m"&mx[1]<0.02300) {a0 <- 0.1429 - 1.99545*mx[1]}
  if (sex=="m"&mx[1] >= 0.02300&mx[1]<0.08307) {a0 <- 0.02832 + 3.26021*mx[1]} 
  if (sex=="m"&mx[1]>=0.08307) {a0 <- 0.29915}
  
  if (sex=="f"&mx[1]<0.01724) {a0 <- 0.14903 - 2.05527*mx[1]}  
  if (sex=="f"&mx[1] >= 0.01724&mx[1]<0.06891) {a0 <- 0.04667 + 3.88089*mx[1]}
  if (sex=="f"&mx[1]>=0.06891) {a0 <- 0.31411}   
  
  if (sex=="b"&mx[1]<0.02012) {a0 <- 0.145965 - 2.02536*mx[1]}
  if (sex=="b"&mx[1] >= 0.02012&mx[1]<0.07599) {a0 <- 0.037495 + 3.57055*mx[1]}
  if (mx[1]>=0.07599) {a0 <- 0.30663}   
  
  
  ax0 <- c(a0)
  ax1 <- rep(0.5, Nx-1)
  ax <- append(ax0, ax1)     # ax values
  
  qx <- (nx*mx)/(1+(1-ax)*nx*mx)   # probabilities of dying
  qx[Nx] <- 1
  
  lx <- numeric()
  lx[1] <- 100000  # Survival function lx
  for (j in 2:Nx) { lx[j] <- lx[j-1]*(1-qx[j-1]) }                  
  
  dx <- lx*qx     # Numbers of dying
  
  Lx <- lx*nx - dx*(1-ax)*nx   # Person-years liven withing age group x
  Lx[Nx] <- lx[Nx]*(1/mx[Nx])
  
  Tx <- numeric()   # Person-years lived after age x
  Tx[Nx] <- Lx[Nx]
  for (j in seq(from=Nx-1, to=1, by=-1)) { Tx[j] <- Tx[j+1]+Lx[j] }
  
  ex <- Tx / lx   # Life expectancy at age x
  
  LT <- data.frame(cbind(Popx, Sexx, x, nx, mx, ax, qx, lx, dx, Lx, Tx, ex))
  for (i in 3:12) {
    LT[,i] <- as.numeric(LT[,i])
    
    return(LT)  
  }
  
}

# Getting path to the folder from which the R-code started and defining working directory
library(rstudioapi)
Cur_dir = dirname(getSourceEditorContext()$path)
setwd(Cur_dir)

cat ("======= CURRENT WORKING DIRECTORY ========================================", "\n", "\n")
getwd()
cat("\n", "\n", "====================================", "\n")

Data = read.csv("ex_ci2005_2021-vs3.csv", header = TRUE)

# Npop = 114  # Number of populations = 38countrx3sexes
Niter = 2000  # Number of Monte-Carlo repeats

Ages = unique(Data$Age)
Nages = length(Ages)
Cntrs = unique(Data$Country)
Ncntrs = length(Cntrs)
Sexes = unique(Data$Sex)
Nsexes = length(Sexes)

Npop = Ncntrs * Nsexes

AgeNum1 = which(Ages == 0)
AgeNum2 = which(Ages == 65)


CCCC = character()
SSSS = character()
AAAA = numeric()
YYYY = numeric()
# EEx = numeric()
# EEx_lo = numeric() 
# EEx_hi = numeric()
MMx = numeric()
MMx_se = numeric()
MM1x = numeric()

e0   = numeric()
e065 = numeric()
e65  = numeric()
l65  = numeric()
eadj65 = numeric()

OutputLEci = data.frame(SSSS=character(), CCCC=character(), YYYY=numeric(), 
                      e0=numeric(), e0_lo=numeric(), e0_hi=numeric(), 
                      e065=numeric(), e065_lo=numeric(), e065_hi=numeric(), 
                      e65=numeric(), e65_lo=numeric(), e65_hi=numeric(), 
                      l65=numeric(), l65_lo=numeric(), l65_hi=numeric(),
                      eadj65=numeric(), eadj65_lo=numeric(), eadj65_hi=numeric())


# Loop across populations -----------------------------------------------------------
 for (ipop in 1:Npop) {
   
   # Extracting data for a population ---------------------------------
   
   for (ia in 1:Nages)    { 
     
     index = (ipop-1)*Nages + ia
     CCCC[ia] = Data$Country[index]
     SSSS[ia] = Data$Sex[index]
     AAAA[ia] = Data$Age[index]
     YYYY[ia] = Data$Year[index]
     # EEx[ia]  = Data$ex[index]
     # EEx_lo[ia] = Data$ex_lo[index]
     # EEx_hi[ia] = Data$ex_up[index]
     MMx[ia] = Data$mx[index]
     MMx_se[ia] = Data$mx_se[index]
     
                          }
   
        
   cat("************************  ", "Country =  ", CCCC[1], "\n")
   cat("--------", "Sex  = ", SSSS[1], "\n")
   cat("--------", "Year = ", YYYY[1], "\n", "\n")
   
   # cat("   ", "e0 = ", round(EEx[1], 3), round(EEx_lo[1], 3), round(EEx_hi[1], 3),
   # "e65 = ", round(EEx[AgeNum2], 3), round(EEx_lo[AgeNum2], 3), round(EEx_hi[AgeNum2], 3),"\n","\n")
   

   # Calculation of a deterministic life table -------------------------
   
   LTbrief =  LTab(MMx, SSSS[1], CCCC[1])
   for (i in 3:12) {
     LTbrief[,i] = as.numeric(LTbrief[,i])
                    }
    
   
    e0[1]  = LTbrief$ex[AgeNum1]
    e065[1] = (LTbrief$ex[AgeNum1]*LTbrief$lx[AgeNum1]-LTbrief$ex[AgeNum2]*LTbrief$lx[AgeNum2])/
      LTbrief$lx[AgeNum1]
    e65[1] = LTbrief$ex[AgeNum2]
    l65[1] = LTbrief$lx[AgeNum2]
    eadj65[1] = e65[1]*(l65[1]/100000)
    
    
    # Monte-Carlo simulations with calculation of life tables -----------
    
    for (k in 2:Niter)       {
      for (ia in 1:Nages) { MM1x[ia] = rnorm(1, MMx[ia], MMx_se[ia])  }
      LTbrief =  LTab(MM1x, SSSS[1], CCCC[1])
      for (i in 3:12)        {
        LTbrief[,i] = as.numeric(LTbrief[,i])
                              }
      
      e0[k]  = LTbrief$ex[AgeNum1]
      e065[k] = (LTbrief$ex[AgeNum1]*LTbrief$lx[AgeNum1]-LTbrief$ex[AgeNum2]*LTbrief$lx[AgeNum2])/
        LTbrief$lx[AgeNum1]
      e65[k] = LTbrief$ex[AgeNum2]
      l65[k] = LTbrief$lx[AgeNum2]
      eadj65[k] = e65[k]*(l65[k]/100000)
                       }
      E0 = round( e0[1], digits=3 )
      E0_lo = round( quantile(e0, 0.025), digits=3 )
      E0_hi = round( quantile(e0, 0.975), digits=3 )
      E065 = round( e065[1], digits=3 )
      E065_lo = round( quantile(e065, 0.025), digits=3 )
      E065_hi = round( quantile(e065, 0.975), digits=3 )
      E65 = round( e65[1], digits=3)
      E65_lo = round( quantile(e65, 0.025), digits=3 )
      E65_hi = round( quantile(e65, 0.975), digits=3 )
      ll65 = round( l65[1], digits=0 )
      ll65_lo = round( quantile(l65, 0.025), digits=0 )
      ll65_hi = round( quantile(l65, 0.975), digits=0 )
      Eadj65 = round( eadj65[1], digits=3)
      Eadj65_lo = round( quantile(eadj65, 0.025), digits=3 )
      Eadj65_hi = round( quantile(eadj65, 0.975), digits=3 )
      
      
      COUNTRY = CCCC[1]
      SEX = SSSS[1]
      YEAR = YYYY[1]
      
      # Forming the output data -------------------------------------------------
      
      Output = cbind(COUNTRY, SEX, YEAR, E0, E0_lo, E0_hi, E065, E065_lo, E065_hi, 
                     E65, E65_lo, E65_hi, ll65, ll65_lo, ll65_hi, 
                     Eadj65, Eadj65_lo, Eadj65_hi)
        
      OutputLEci = rbind(OutputLEci, Output)
      for (i in 4:18)        {
        OutputLEci[,i] = as.numeric(OutputLEci[,i])
                              }  
        
                                          } # End of the cycle across populations
  
# export ------
write.csv(OutputLEci, "e0-e065-e65-l65-ci-2021-3.csv", row.names=FALSE, quote=FALSE)

