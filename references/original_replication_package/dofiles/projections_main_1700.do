********************************************************************************
**************Local projections --- baseline specifications*********************
********************************************************************************

preserve

******Set horizon and end-year:
local maxproj 12
local endyear 1700
 
******Generation of LHS variables
forvalues i=0/`maxproj' {
	
	gen ln_price`i' = f`i'.lnprice-l.lnprice
	gen ln_realGDP`i'= f`i'.ln_realGDP-l.ln_realGDP
	gen ln_nominal`i' = f`i'.lnnominal-l.lnnominal
	gen ln_moneystock`i' = f`i'.lnmoneystock-l.lnmoneystock
}



*****Specification of control variables 


local control1 L(1/4)ln_realGDP year i.cnumber#c.year year2 i.cnumber#c.year2 i.warspain l(0/4).temperature 

local control2 L(1/4)lnprice year i.cnumber#c.year year2 i.cnumber#c.year2 i.warspain l(0/4).temperature 

local control3 L(1/4)lnnominal year i.cnumber#c.year year2 i.cnumber#c.year2 i.warspain l(0/4).temperature 

local control4 L(1/4)lnmoneystock year i.cnumber#c.year year2 i.cnumber#c.year2 i.warspain l(0/4).temperature 


*****Storing coefficients, standard errors and degrees of freedom
gen b_ln_realGDP=.
gen se_ln_realGDP=.

gen b_ln_realGDPpercap=.
gen se_ln_realGDPpercap=.

gen b_ln_price  =.
gen se_ln_price =.

gen b_ln_nominal  =.
gen se_ln_nominal =.

gen b_ln_moneystock  =.
gen se_ln_moneystock =.

gen resdof =.



*****Local Projections
	

forvalues i=0/`maxproj' {	
	
	
	xtreg ln_realGDP`i' $shock  `control1' if  year<=`endyear',  fe vce(cluster cnumber) 
	eststo ols_ln_realGDP`i'
	
	replace b_ln_realGDP  = _b[$shock] if _n == `i'+1
	replace se_ln_realGDP = _se[$shock] if _n == `i'+1
	replace resdof = e(df_r) if _n == `i'+1

	xtreg ln_price`i' $shock `control2' if year<=`endyear',  fe vce(cluster cnumber) 
	eststo ols_ln_price`i'
	
	replace b_ln_price  = _b[$shock] if _n == `i'+1
	replace se_ln_price = _se[$shock] if _n == `i'+1
			
	xtreg ln_nominal`i' $shock `control3' if year<=`endyear',  fe vce(cluster cnumber) 
	eststo ols_ln_nominal`i'
	
	replace b_ln_nominal  = _b[$shock] if _n == `i'+1
	replace se_ln_nominal = _se[$shock] if _n == `i'+1		
	

	xtreg ln_moneystock`i' $shock  `control4' if year<=`endyear',  fe vce(cluster cnumber) 
	eststo ols_ln_moneystock`i'
	
	replace b_ln_moneystock  = _b[$shock] if _n == `i'+1
	replace se_ln_moneystock = _se[$shock] if _n == `i'+1		
	
			}



*****Generation of graphs



gen graphyear= _n-1 if _n <= `maxproj' +1

local title1 "Response of real GDP, 1531-`endyear'"
local title2 "Response of prices, 1531-`endyear'"
local title3 "Response of nominal GDP, 1531-`endyear'"
local title4 "Response of European money stock, 1531-`endyear'"


gen zero = 0 if _n <= `maxproj' +1

	


*Significance level lines	
scalar level1 = 0.05	
scalar level2 = 0.1	 


gen up_ln_realGDP = b_ln_realGDP + invt(resdof, level1/2)*se_ln_realGDP if _n <= (`maxproj' + 1)
gen dn_ln_realGDP = b_ln_realGDP - invt(resdof, level1/2)*se_ln_realGDP if _n <= (`maxproj' + 1)

gen up2_ln_realGDP = b_ln_realGDP + invt(resdof, level2/2)*se_ln_realGDP if _n <= (`maxproj' + 1)
gen dn2_ln_realGDP = b_ln_realGDP - invt(resdof, level2/2)*se_ln_realGDP if _n <= (`maxproj' + 1)

gen up3_ln_realGDP = b_ln_realGDP + 1*se_ln_realGDP if _n <= (`maxproj' + 1)
gen dn3_ln_realGDP = b_ln_realGDP - 1*se_ln_realGDP if _n <= (`maxproj' + 1)

gen up_ln_price = b_ln_price + invt(resdof, level1/2)*se_ln_price if _n <= (`maxproj' + 1)
gen dn_ln_price = b_ln_price - invt(resdof, level1/2)*se_ln_price if _n <= (`maxproj' + 1)

gen up2_ln_price = b_ln_price + invt(resdof, level2/2)*se_ln_price if _n <= (`maxproj' + 1)
gen dn2_ln_price = b_ln_price - invt(resdof, level2/2)*se_ln_price if _n <= (`maxproj' + 1)

gen up3_ln_price = b_ln_price + 1*se_ln_price if _n <= (`maxproj' + 1)
gen dn3_ln_price = b_ln_price - 1*se_ln_price if _n <= (`maxproj' + 1)


gen up_ln_nominal = b_ln_nominal + invt(resdof, level1/2)*se_ln_nominal if _n <= (`maxproj' + 1)
gen dn_ln_nominal = b_ln_nominal - invt(resdof, level1/2)*se_ln_nominal if _n <= (`maxproj' + 1)

gen up2_ln_nominal = b_ln_nominal + invt(resdof, level2/2)*se_ln_nominal if _n <= (`maxproj' + 1)
gen dn2_ln_nominal = b_ln_nominal - invt(resdof, level2/2)*se_ln_nominal if _n <= (`maxproj' + 1)

gen up3_ln_nominal = b_ln_nominal + 1*se_ln_nominal if _n <= (`maxproj' + 1)
gen dn3_ln_nominal = b_ln_nominal - 1*se_ln_nominal if _n <= (`maxproj' + 1)


gen up_ln_moneystock = b_ln_moneystock + invt(resdof, level1/2)*se_ln_moneystock if _n <= (`maxproj' + 1)
gen dn_ln_moneystock = b_ln_moneystock - invt(resdof, level1/2)*se_ln_moneystock if _n <= (`maxproj' + 1)

gen up2_ln_moneystock = b_ln_moneystock + invt(resdof, level2/2)*se_ln_moneystock if _n <= (`maxproj' + 1)
gen dn2_ln_moneystock = b_ln_moneystock - invt(resdof, level2/2)*se_ln_moneystock if _n <= (`maxproj' + 1)

gen up3_ln_moneystock = b_ln_moneystock + 1*se_ln_moneystock if _n <= (`maxproj' + 1)
gen dn3_ln_moneystock = b_ln_moneystock - 1*se_ln_moneystock if _n <= (`maxproj' + 1)
	
	
	
	
*The graphs	

twoway (rarea up_ln_realGDP dn_ln_realGDP  graphyear, ///
fcolor(gs13) lcolor(white) lpattern(solid) )  ///
(rarea up2_ln_realGDP dn2_ln_realGDP  graphyear, ///
fcolor(gs10) lcolor(white) lpattern(solid) ) ///
(rarea up3_ln_realGDP dn3_ln_realGDP  graphyear, ///
fcolor(gs6) lcolor(white) lpattern(solid) ) ///
(line b_ln_realGDP graphyear, lcolor(black) ///
lpattern(solid) lwidth(thick)) /// 
(line zero graphyear, lcolor(black)), ///
title("`title1'", color(black) size(medium)) ///
ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
graphregion(color(white)) plotregion(color(white)) ///
legend(off) name(real, replace) ///
xlabel(0(1)12)


twoway (rarea up_ln_price dn_ln_price  graphyear, ///
fcolor(gs13) lcolor(white) lpattern(solid)) ///
(rarea up2_ln_price dn2_ln_price graphyear, ///
fcolor(gs10) lcolor(white) lpattern(solid)) ///
(rarea up3_ln_price dn3_ln_price graphyear, ///
fcolor(gs6) lcolor(white) lpattern(solid)) ///
(line b_ln_price graphyear, lcolor(black) ///
lpattern(solid) lwidth(thick)) /// 
(line zero graphyear, lcolor(black)), ///
title("`title2'", color(black) size(medium)) ///
ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
graphregion(color(white)) plotregion(color(white)) ///
legend(off) name(price, replace) ///
xlabel(0(1)12)



twoway (rarea up_ln_nominal dn_ln_nominal  graphyear, ///
fcolor(gs13) lcolor(white) lpattern(solid)) ///
(rarea up2_ln_nominal dn2_ln_nominal graphyear, ///
fcolor(gs10) lcolor(white) lpattern(solid)) ///
(rarea up3_ln_nominal dn3_ln_nominal graphyear, ///
fcolor(gs6) lcolor(white) lpattern(solid)) ///
(line b_ln_nominal graphyear, lcolor(black) ///
lpattern(solid) lwidth(thick)) /// 
(line zero graphyear, lcolor(black)), ///
title("`title3'", color(black) size(medium)) ///
ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
graphregion(color(white)) plotregion(color(white)) ///
legend(off) name(nominal, replace) ///
xlabel(0(1)12)

	
twoway (rarea up_ln_moneystock dn_ln_moneystock  graphyear, ///
fcolor(gs13) lcolor(white) lpattern(solid)) ///
(rarea up2_ln_moneystock dn2_ln_moneystock graphyear, ///
fcolor(gs10) lcolor(white) lpattern(solid)) ///
(rarea up3_ln_moneystock dn3_ln_moneystock graphyear, ///
fcolor(gs6) lcolor(white) lpattern(solid)) ///
(line b_ln_moneystock graphyear, lcolor(black) ///
lpattern(solid) lwidth(thick)) /// 
(line zero graphyear, lcolor(black)), ///
title("`title4'", color(black) size(medium)) ///
ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
graphregion(color(white)) plotregion(color(white)) ///
legend(off) name(moneystock, replace) ///
xlabel(0(1)12)
	
*Combining the graphs	
graph combine nominal price real moneystock, name(projections_main_`endyear', replace) rows(2) imargin(medsmall) plotregion(color(white)) graphregion(color(white)) 
graph display projections_main_`endyear', ysize(4) xsize(7)
graph export "$diroutput/projections_main_`endyear'.png", replace 	
	
restore		