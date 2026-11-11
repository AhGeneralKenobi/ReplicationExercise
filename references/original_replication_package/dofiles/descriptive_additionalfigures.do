
preserve

use "$dirdata/datadescriptive.dta", clear


*Figure 2
twoway (line tnssilvernew year if year<=1790 & year>=1530, color(black) ylabel(, angle(0))) (line tnsgoldnew year  if year<=1790 & year>=1530, color(gray)) (line tnstotalnew year if year<=1790 & year>=1530, color(black*.95)  ytitle(silver-equivalent tonnes) xlabel(1530(10)1790, angle(90)) lpattern(dash)), legend( order( 1 "silver production" 2 "gold production" 3 "total production" ) ) 
graph export "$diroutput/pmetals_goldsilver.png", replace 	



*Figure 3
twoway (bar top year if inrange(year, 1573, 1573) , bcolor(gs14) base(0) barwidth(5)) (line silvertonspotosi year if year>=1550 & year<=1600, color(black) ytitle(tons of silver) ), legend(order(1 "Amalgamation period" 2 "Production of silver in Potosí")) 
graph export "$diroutput/potosiamalgamation.png", replace 	



*Figure 7
twoway (area goldshare year if year>=1530 & year<=1790, color(black*.85) ytitle(share of gold in total production)   xlabel(1530(10)1790, angle(90))  ylabel(0(20)100, angle(0))  )      	
graph export "$diroutput/goldandsilver.png", replace 	


*Figure 11
twoway (bar Hollandmintoutputinsilverun year if year>=1530, color(black) yaxis(1)  ytitle("", axis(1)) ylabel(0(500)4000, axis(1) angle(0))) (bar Francemintoutputinsilveruni year if year>=1530, color(black*.75) xlabel(1530(10)1810, angle(90))) (bar Genoamintoutputinsilverunit year if year>=1530, color(gray)) (line tnstotalnew year if year>=1530, color(black) lpattern(dash) yaxis(2) ytitle("", axis(2)) ylabel(0(100)1000, axis(2) angle(0))), legend(col(1) order(1 "Holland mint output (index 1693=100, left scale)" 2 "France mint output (index 1696-1705=100, left scale)" 3 "Genoa mint output (index 1696-1705=100, left scale)" 4 "New World precious metals poduction (tonnes, right scale)")) 
graph export "$diroutput/HOLLANDfrancemint.png", replace 	


*Figure 12
twoway (bar englandmintmillions year if year>=1530 & year<=1790, xlabel(1530(10)1790, angle(90)) ytitle("Total mint output (millions of £)")  ylabel(0(1)5, angle(0))  color(black)   legend(col(1)))
graph export "$diroutput/ENGLANDmint.png", replace 	



*Figure 17
twoway (bar innovation year if year>=1720 & year<=1790, color(black) barwidth(0.85) ylabel(-20(5)10) xlabel(1720(5)1790, angle(90)) ytitle("actual minus predicted gold arrivals, in tonnes"))
graph export "$diroutput/INNOV.png", replace 	

restore
