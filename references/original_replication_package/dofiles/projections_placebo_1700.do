********************************************************************************
**************Local projections - placebo***************************************
********************************************************************************

preserve

******Set horizon
local maxproj 12
 
******Generation of LHS variables, in levels. Projections are into the past.
forvalues i=1/`maxproj' {
	
	gen ln_realGDP`i'= ln_realGDP-l`i'.ln_realGDP
	
}




*****Specification of control variables (if any)


local control1 L(1/4)ln_realGDP  year i.cnumber#c.year year2 i.cnumber#c.year2 i.warspain l(0/4).temperature 


*****Storing coefficients, standard errors and degrees of freedom

gen b_ln_realGDP=.
gen se_ln_realGDP=.
gen resdof =.




******Local Projections	

local endyear 1700

forvalues i=1/`maxproj' {	
	
	
	xtreg ln_realGDP`i' $shock  `control1' if  year<=`endyear',  fe vce(cluster cnumber) 
	eststo ols_ln_realGDP`i'
	
	replace b_ln_realGDP  = _b[$shock] if _n == `i'+1
	replace se_ln_realGDP = _se[$shock] if _n == `i'+1
	replace resdof = e(df_r) if _n == `i'+1


			}



******Generation of graph



gen graphyear= _n-1 if _n <= `maxproj' +1
gen neggraphyear= -graphyear if _n <= `maxproj' +1

local title1 "Response of past real GDP, 1531-`endyear'"
local title2 "Response of prices, 1531-`endyear'"
local title3 "Response of nominal GDP, 1531-`endyear'"

gen zero = 0 if neggraphyear < 0


****Significance level lines	
scalar level1 = 0.05	
scalar level2 = 0.1	


gen up_ln_realGDP = b_ln_realGDP + invt(resdof, level1/2)*se_ln_realGDP if _n <= (`maxproj' + 1)
gen dn_ln_realGDP = b_ln_realGDP - invt(resdof, level1/2)*se_ln_realGDP if _n <= (`maxproj' + 1)

gen up2_ln_realGDP = b_ln_realGDP + invt(resdof, level2/2)*se_ln_realGDP if _n <= (`maxproj' + 1)
gen dn2_ln_realGDP = b_ln_realGDP - invt(resdof, level2/2)*se_ln_realGDP if _n <= (`maxproj' + 1)

	gen up3_ln_realGDP = b_ln_realGDP + 1*se_ln_realGDP if _n <= (`maxproj' + 1)
gen dn3_ln_realGDP = b_ln_realGDP - 1*se_ln_realGDP if _n <= (`maxproj' + 1)

	
	
****The graphs	

	twoway (rarea up_ln_realGDP dn_ln_realGDP  neggraphyear, ///
	fcolor(gs13) lcolor(white) lpattern(solid) )  ///
	(rarea up2_ln_realGDP dn2_ln_realGDP  neggraphyear, ///
	fcolor(gs10) lcolor(white) lpattern(solid) ) ///
	(rarea up3_ln_realGDP dn3_ln_realGDP  neggraphyear, ///
	fcolor(gs6) lcolor(white) lpattern(solid) ) ///
	(line b_ln_realGDP neggraphyear, lcolor(black) ///
	lpattern(solid) lwidth(thick)) /// 
	(line zero neggraphyear, lcolor(black)), ///
	title("`title1'", color(black) size(medium)) ///
	ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
	graphregion(color(white)) plotregion(color(white)) ///
	legend(off) name(real, replace) ///
	xlabel(-12(1)-1)
	graph export "$diroutput/projections_placebo_`endyear'_real.png", replace 	

restore	
	