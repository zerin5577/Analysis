**** Article Replication ****

tsset trend

** Stationary Check **
dfuller FFR 
dfuller DGS2 
dfuller DGS10 
gen dDGS10=d.DGS10 
dfuller dDGS10 
dfuller BKEVENF5 
dfuller T5YIFR 
gen dT5YIFR=d.T5YIFR 
dfuller dT5YIFR 
dfuller DAAA 
dfuller DBAA 

** DSG2
varsoc DGS2 FFR 
varbasic DGS2 FFR, lags (1/3) step(90)
* model defined (one lag)
varbasic DGS2 FFR, lags (1) step(90)
quietly var DGS2 FFR if trend< 472, lags(1)
fcast compute F_, step (90)
tsline DGS2 F_DGS2 if trend> 472, name(two_year_treasury_forecast)
var DGS2 FFR, lags (1)
irf creat DGS2test, set (DGS2test, replace) step (90) order (FFR DGS2)
irf graph oirf, set (DGS2test) irf(DGS2test) impulse (FFR) response (DGS2) yline(0) name(Two_Year_Treasury)

** DSG10
varsoc DGS10 FFR
varbasic DGS10 FFR, lags (1/2) step(90)
* model defined (two lag)
varbasic DGS2 FFR, lags (1) step(90)
quietly var DGS10 FFR if trend< 472, lags(1)
fcast compute F2_, step (90)
tsline DGS10 F2_DGS10 if trend> 472, name(ten_year_treasury_forecast)
var DGS10 FFR, lags (1)
irf creat DGS10test, set (DGS10test, replace) step (90) order (FFR DGS10)
irf graph oirf, set (DGS10test) irf(DGS10test) impulse (FFR) response (DGS10) yline(0) name(Ten_Year_Treasury)

** BKEVENF5
varsoc BKEVENF5 FFR
varbasic BKEVENF5 FFR, lags(1/3) step (90)
* model defined (two lag)
varbasic BKEVENF5 FFR, lags(1/2) step (90)
quietly var BKEVENF5 FFR if trend< 472, lags(1/2)
fcast compute F3_, step (90)
tsline DGS10 F2_DGS10 if trend> 472, name(Five_Year_Breakeven_Forecast)
var BKEVENF5 FFR, lags (1/2)
irf creat BKEVENF5test, set (BKEVENF5test, replace) step (90) order (FFR BKEVENF5)
irf graph oirf, set (BKEVENF5test) irf(BKEVENF5test) impulse (FFR) response (BKEVENF5) yline(0) name(BKEVEN5)

** T5YIFR
varsoc FFR T5YIFR
* model defined (two lag)
varbasic T5YIFR FFR, lags(1/2) step(90)
quietly var T5YIFR FFR if trend< 472, lags(1/2)
fcast compute F4_, step (90)
tsline T5YIFR F4_T5YIFR if trend> 472, name(Five_To_Ten_Inflation_Forecast)
var T5YIFR FFR, lags (1/2)
irf creat T5YIFRtest, set (T5YIFRtest, replace) step (90) order (FFR T5YIFR)
irf graph oirf, set (T5YIFRtest) irf(T5YIFRtest) impulse (FFR) response (T5YIFR) yline(0) name(Five_To_Ten)

*** AAA
varsoc DAAA FFR
varbasic DAAA FFR, lags(1/3) step(90)
* model defined (two lag)
varbasic DAAA FFR, lags(1/2) step(90)
quietly var DAAA FFR if trend< 472, lags(1/2)
fcast compute F5_, step (90)
tsline DAAA F5_DAAA if trend> 472, name(AAA_Forecast)
var DAAA FFR, lags (1/2)
irf creat DAAAtest, set (DAAAtest, replace) step (90) order (FFR DAAA)
irf graph oirf, set (DAAAtest) irf(DAAAtest) impulse (FFR) response (DAAA) yline(0) name(AAA)

*** BAA
varsoc DBAA FFR
varbasic DBAA FFR, lags(1/3) step(90)
* model defined (two lag)
varbasic DBAA FFR, lags(1/2) step(90)
quietly var DBAA FFR if trend< 472, lags(1/2)
fcast compute F6_, step (90)
tsline DBAA F6_DBAA if trend> 472, name(BAA_Forecast)
var DBAA FFR, lags (1/2)
irf creat DBAAtest, set (DBAAtest, replace) step (90) order (FFR DBAA)
irf graph oirf, set (DBAAtest) irf(DBAAtest) impulse (FFR) response (DBAA) yline(0) name(BAA)

*** graph combine Forecast ***
graph combine two_year_treasury_forecast ten_year_treasury_forecast Five_Year_Breakeven_Forecast Five_To_Ten_Inflation_Forecast AAA_Forecast BAA_Forecast
graph combine Two_Year_Treasury Ten_Year_Treasury BKEVEN5 Five_To_Ten AAA BAA
 



