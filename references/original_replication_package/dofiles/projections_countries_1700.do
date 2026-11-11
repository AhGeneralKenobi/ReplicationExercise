
********************************************************************************
***********************Country-specific LPs*************************************
********************************************************************************

preserve


gen long obs = _n

******Set horizon and end-year:
local maxproj 12
local endyear 1700

 
******Generation of LHS variables
forvalues i=0/`maxproj' {
	
	gen ln_realGDP`i'= f`i'.ln_realGDP-l.ln_realGDP

	
}



*****Specification of control variables

local control1 L(1/4)ln_realGDP  year year2 i.warspain l(0/4).temperature 




foreach j in 1 2 3 4 5 6  {	


*****Storing coefficients, standard errors and degrees of freedom
gen b_ln_realGDP`j'=.
gen se_ln_realGDP`j'=.
gen resdof`j'=.


*****Local Projections

    su obs if cnumber == `j', meanonly
    local t = country[r(min)]
	
	





forvalues i=0/`maxproj' {
	
	newey ln_realGDP`i' $shock `control1' if cnumber==`j' & year<=`endyear', lag(1)

	eststo ols_ln_realGDP`j'`i'
	
	replace b_ln_realGDP`j'  = _b[$shock] if _n == `i'+1
	replace se_ln_realGDP`j' = _se[$shock] if _n == `i'+1
	replace resdof`j'= e(df_r) if _n == `i'+1
	
			}



*****Generation of graphs



gen graphyear= _n-1 if _n <= `maxproj' +1


local title1 " `t', real GDP"




gen zero = 0 if _n <= `maxproj' +1



*Significance level lines	
scalar level1 = 0.05	
scalar level2 = 0.1	

	
gen up_ln_realGDP`j' = b_ln_realGDP`j' + invt(resdof`j', level1/2)*se_ln_realGDP`j' if _n <= (`maxproj' + 1)
gen dn_ln_realGDP`j' = b_ln_realGDP`j' - invt(resdof`j', level1/2)*se_ln_realGDP`j' if _n <= (`maxproj' + 1)

gen up2_ln_realGDP`j' = b_ln_realGDP`j' + invt(resdof`j', level2/2)*se_ln_realGDP`j' if _n <= (`maxproj' + 1)
gen dn2_ln_realGDP`j' = b_ln_realGDP`j' - invt(resdof`j', level2/2)*se_ln_realGDP`j' if _n <= (`maxproj' + 1)

gen up3_ln_realGDP`j' = b_ln_realGDP`j' + 1*se_ln_realGDP`j' if _n <= (`maxproj' + 1)
gen dn3_ln_realGDP`j' = b_ln_realGDP`j' - 1*se_ln_realGDP`j' if _n <= (`maxproj' + 1)

	
****The graphs	


	
	twoway (rarea up_ln_realGDP`j' dn_ln_realGDP`j'  graphyear, ///
	fcolor(gs13) lcolor(white) lpattern(solid)) ///
	(rarea up2_ln_realGDP`j' dn2_ln_realGDP`j'  graphyear, ///
	fcolor(gs10) lcolor(white) lpattern(solid)) ///
	(rarea up3_ln_realGDP`j' dn3_ln_realGDP`j'  graphyear, ///
	fcolor(gs6) lcolor(white) lpattern(solid)) ///
	(line b_ln_realGDP`j' graphyear, lcolor(black) ///
	lpattern(solid) lwidth(thick)) /// 
	(line zero graphyear, lcolor(black)), ///
	title("`title1'", color(black) size(medium)) ///
	ytitle("Percent", size(medsmall)) xtitle("Year", size(medsmall)) ///
	graphregion(color(white)) plotregion(color(white)) xlabel(0(1)12) ///
	legend(off) name(real_country`j', replace)
	
	drop graphyear
	drop zero
	}	
	

*Combining the graphs
graph combine real_country1 real_country2 real_country3 real_country4 real_country5 real_country6 , name(projections_countries_real, replace) rows(2) cols(3) imargin(medsmall) plotregion(color(white)) graphregion(color(white)) 
graph display projections_countries_real, ysize(3) xsize(4)
graph export "$diroutput/projections_countries_real_`endyear'.png", replace 	

restore