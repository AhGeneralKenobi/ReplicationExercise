********************************************************************************
**************Local projections - IV for England, lag=0 for first stage*********
********************************************************************************

preserve

*****keep only English data


drop if cnumber!=1

tsset year


****set endogenous variable
local end ln_mint_adj


******Set horizon
local maxproj 12


******Generation of LHS-Variables
forvalues i=0/`maxproj' {
	
	gen ln_price`i' = f`i'.lnprice-l.lnprice
	gen ln_realGDP`i'= f`i'.ln_realGDP-l.ln_realGDP
	gen ln_nominal`i' = f`i'.lnnominal-l.lnnominal
}





*****Storing coefficients, standard errors and degrees of freedom

gen b_ln_realGDP=.
gen se_ln_realGDP=.

gen b_ln_price  =.
gen se_ln_price =.

gen b_ln_nominal  =.
gen se_ln_nominal =.

gen resdof =.
	
	
******Local Projections	
*Note: The following code also outputs the first-stage regression that is used in Table 3, Column 2. 
*In paticular, the coefficient and standard error of "metals_prod_ship5y" is shown in the table.
*The F-statistic can be obtained by squaring the t-statistic of "metals_prod_ship5y".

local end ln_mint_adj

gen graphyear= _n-1 if _n <= `maxproj' +1
gen zero = 0 if _n <= `maxproj' +1
	
forvalues i=0/`maxproj' {	
	
if  `i'== 0  {	
	
log using "$diroutput/Table3_col2.log", replace
	
	
	ivregress 2sls ln_realGDP`i' (`end' = $englandshock) year year2 i.cottington if cnumber==1 & year>=1559 & year<=1700, vce(hac nw 1) small first 
	eststo ols_ln_realGDP`i'
	
	replace b_ln_realGDP  =  _b[`end'] if _n == `i'+1
	replace se_ln_realGDP = _se[`end'] if _n == `i'+1
	replace resdof = e(df_r) if _n == `i'+1

	log close
	
	ivregress 2sls ln_price`i' (`end' = $englandshock) year year2 i.cottington  if cnumber==1 & year>=1559 & year<=1700, vce(hac nw 1) small first 
	eststo ols_ln_price`i'
	
	replace b_ln_price  =  _b[`end'] if _n == `i'+1
	replace se_ln_price = _se[`end'] if _n == `i'+1

	ivregress 2sls ln_nominal`i' (`end' = $englandshock)  year year2 i.cottington if cnumber==1 & year>=1559 & year<=1700, vce(hac nw 1) small first 
	eststo ols_ln_nominal`i'
	
	replace b_ln_nominal  =  _b[`end'] if _n == `i'+1
	replace se_ln_nominal = _se[`end'] if _n == `i'+1
				
}				
else {				
	
	ivregress 2sls ln_realGDP`i' (`end' = $englandshock) year year2 i.cottington if cnumber==1 & year>=1559 & year<=1700, vce(hac nw 1) small first 
	eststo ols_ln_realGDP`i'
	
	replace b_ln_realGDP  =  _b[`end'] if _n == `i'+1
	replace se_ln_realGDP = _se[`end'] if _n == `i'+1
	replace resdof = e(df_r) if _n == `i'+1

	ivregress 2sls ln_price`i' (`end' = $englandshock) year year2 i.cottington  if cnumber==1 & year>=1559 & year<=1700, vce(hac nw 1) small first 
	eststo ols_ln_price`i'
	
	replace b_ln_price  =  _b[`end'] if _n == `i'+1
	replace se_ln_price = _se[`end'] if _n == `i'+1

	ivregress 2sls ln_nominal`i' (`end' = $englandshock)  year year2 i.cottington if cnumber==1 & year>=1559 & year<=1700, vce(hac nw 1) small first 
	eststo ols_ln_nominal`i'
	
	replace b_ln_nominal  =  _b[`end'] if _n == `i'+1
	replace se_ln_nominal = _se[`end'] if _n == `i'+1
		
	}
				
				}

restore