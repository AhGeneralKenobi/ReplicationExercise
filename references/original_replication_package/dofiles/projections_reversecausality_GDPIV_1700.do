********************************************************************************
**************Local projections --- baseline specifications*********************
********************************************************************************

preserve

******Set horizon and end-year:

local maxproj 12
local endyear 1700
 
 
******Generation of LHS variables

forvalues i=0/`maxproj' {
	
	gen metals_prod`i' = f`i'.$shock -l.$shock
	
}

 
*****Storing coefficients, standard errors and degrees of freedom
gen b_metals_prod=.
gen se_metals_prod=.
gen resdof=.

*****Local Projections
*Note: The following code also outputs the first-stage regression that is used in Table 4. 


forvalues i=0/`maxproj' {	
	
	if  `i'== 0 {
	
log using "$diroutput/Table4.log", replace
	
	
	xtivreg metals_prod`i' (ln_realGDP = l(0/2)temperature) `control1' if year<=`endyear',  first fe vce(cluster cnumber)
	eststo ols_metals_prod`i'
	
	replace b_metals_prod = _b[ln_realGDP] if _n == `i'+1
	replace se_metals_prod = _se[ln_realGDP] if _n == `i'+1
	replace resdof = 5 if _n == `i'+1
	
	log close
	
	}
	
	else {
	
	xtivreg metals_prod`i' (ln_realGDP = l(0/2)temperature) `control1' if  year<=`endyear',  first fe vce(cluster cnumber)
	eststo ols_metals_prod`i'
	
	replace b_metals_prod = _b[ln_realGDP] if _n == `i'+1
	replace se_metals_prod = _se[ln_realGDP] if _n == `i'+1
	replace resdof = 5 if _n == `i'+1
	
	}
	
			}


*****Generation of graphs


gen graphyear= _n-1 if _n <= `maxproj' +1

local title1 "Response of precious metals to GDP (instrumented), 1531-`endyear'"



gen zero = 0 if _n <= `maxproj' +1


****Significance level lines	
scalar level1 = 0.05	
scalar level2 = 0.1	 


gen up_metals_prod = b_metals_prod + invnormal(level1/2)*se_metals_prod if _n <= (`maxproj' + 1)
gen dn_metals_prod = b_metals_prod - invnormal(level1/2)*se_metals_prod if _n <= (`maxproj' + 1)

gen up2_metals_prod = b_metals_prod + invnormal(level2/2)*se_metals_prod if _n <= (`maxproj' + 1)
gen dn2_metals_prod = b_metals_prod - invnormal(level2/2)*se_metals_prod if _n <= (`maxproj' + 1)

gen up3_metals_prod = b_metals_prod + 1*se_metals_prod if _n <= (`maxproj' + 1)
gen dn3_metals_prod = b_metals_prod - 1*se_metals_prod if _n <= (`maxproj' + 1)



****The graphs	

twoway (rarea up_metals_prod dn_metals_prod  graphyear, ///
fcolor(gs13) lcolor(white) lpattern(solid) )  ///
(rarea up2_metals_prod dn2_metals_prod  graphyear, ///
fcolor(gs10) lcolor(white) lpattern(solid) ) ///
(rarea up3_metals_prod dn3_metals_prod  graphyear, ///
fcolor(gs6) lcolor(white) lpattern(solid) ) ///
(line b_metals_prod graphyear, lcolor(black) ///
lpattern(solid) lwidth(thick)) /// 
(line zero graphyear, lcolor(black)), ///
title("`title1'", color(black) size(medium)) ///
ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
graphregion(color(white)) plotregion(color(white)) ///
legend(off) name(real, replace) ///
xlabel(0(1)12)
graph export "$diroutput/projection_`endyear'_reverse_GDPIV.png",  replace

	
restore	
	