********************************************************************************
****************Generation of descriptive figures*******************************
********************************************************************************



*Figure 4: Nominal GDP
xtline Nominal_GDPindex1700100, byopt(note(" ") graphregion(color(white)) plotregion(color(white)) ) ytitle("Nominal GDP, index (1700=100) ") lcolor(black) graphregion(color(white)) plotregion(color(white)) lwidth(large) legend(label(1 "England"))
graph export "$diroutput/nominal_descriptive.png", replace 	

*Figure 5: Prices
xtline GDP_deflatorpricelevelinde, byopt(note(" ") graphregion(color(white)) plotregion(color(white)) ) ytitle("Price level, index (1700=100) ")  lcolor(black) graphregion(color(white)) plotregion(color(white)) lwidth(large) legend(label (1 "England"))
graph export "$diroutput/prices_descriptive.png", replace 	

*Figure 6: Real GDP
xtline realGDPindex1700, byopt(note(" ") graphregion(color(white)) plotregion(color(white)) ) ytitle("Real GDP, index (1700=100) ") lcolor(black) color(white) lwidth(large) legend(label (1 "England"))
graph export "$diroutput/real_descriptive.png", replace 	

*Figure 8: shock variable but without logs 
twoway (tsline $metals_nologs if country=="England/GB", lpattern(solid) lcolor(black)), ytitle("precious metals relative to stock")  graphregion(color(white)) plotregion(color(white)) 
graph export "$diroutput/metals_descriptive.png", replace 	


		