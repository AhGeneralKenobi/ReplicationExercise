*Do-file for Palma, N. (2021, forthcoming). 
*The real effects of monetary expansions: evidence from a large-scale historical experiment. 
*Review of Economic Studies.

********************************************************************************
*****Install STATA packages
********************************************************************************

***The following packages are used in the dofiles: "labutil" and "estout". If you do not have them installed, run the following commands:

*ssc install labutil
*ssc install estout



********************************************************************************
*****Define directories and macros, load dataset********************************
********************************************************************************

***print current working directory
pwd

***set directory where the data is located, for instance the directory printed above (which is the default)
global dirdata "`c(pwd)'/data"

***set folder where main dofiles are located 
global dirdofiles "`c(pwd)'/dofiles"

***set folder where output is produced 
global diroutput "`c(pwd)'/output"

***load dataset
use "$dirdata/liquidity.dta", clear


***set main shock variables
global shock metals_prod_ship
global metals_nologs metals_nologs_shipnotcombat
global englandshock metals_prod_ship5y

***format panel data and set figures to black and white 
xtset cnumber year, yearly
labmask cnumber, values(country)
set scheme s1mono


********************************************************************************
*****Codes for figures and tables***********************************************
********************************************************************************

***Figures 2, 3, 7, 11, 12, 17
do "$dirdofiles/descriptive_additionalfigures.do" 

***Figures 4, 5, 6 and 8
do "$dirdofiles/descriptive_figures.do" 

*Figure 9:
do "$dirdofiles/projections_main_1700.do"  

*F**igure 10:
do "$dirdofiles/projections_countries_1700.do" 


***Figures 13-14 and Table 3, Column 1:
//Note: 
//Results for Column 1 produced in "Table3_Column1.log". Log-file contains two tables.
//First output table in log file entitlted "First-stage regressions" gives the
//reported coefficient (first lag of "metals_prod_ship5y"), its p-value, as well
//as its t-statistic. The F-statistic reported in Table 3 of the paper 
//is the square of the t-statistic of metals_prod_ship5y in the log file. 
do "$dirdofiles/projections_EnglandIV_baseline_1700.do" 

***Table 3, Column 2:
//Note: 
//Results for Column 2 produced in "Table3_Column2.log". Log-file contains two tables.
//First output table in log file entitlted "First-stage regressions" gives the
//reported coefficient ("metals_prod_ship5y"), its p-value, as well
//as its t-statistic. The F-statistic reported in Table 3 of the paper 
//is the square of the t-statistic of metals_prod_ship5y in the log file. 
do "$dirdofiles/projections_EnglandIV_lag0_1700.do" 



***Table 3, Column 3:
//Note: 
//Results for Column 3 produced in "Table3_Column3.log". Log-file contains two tables.
//First output table in log file entitlted "First-stage regressions" gives the
//reported coefficient (second lag of "metals_prod_ship5y"), its p-value, as well
//as its t-statistic. The F-statistic reported in Table 3 of the paper 
//is the square of the t-statistic of metals_prod_ship5y in the log file. 
do "$dirdofiles/projections_EnglandIV_lag2_1700.do" 

***Table 3, Column 4:
//Note: 
//Results for Column 4 produced in "Table3_Column4.log". Log-file contains two tables.
//First output table in log file entitlted "First-stage regressions" gives the
//reported coefficient (variable "metals_prod_ship5y"), its p-value, as well
//as its t-statistic. The F-statistic reported in Table 3 of the paper 
//is the square of the t-statistic of metals_prod_ship5y in the log file. 
do "$dirdofiles/projections_EnglandIV_nocott_1700.do"

***Table 3, Column 5:
//Note: 
//Results for Column 5 produced in "Table3_Column5.log". Log-file contains two tables.
//First output table in log file entitlted "First-stage regressions" gives the
//reported coefficient (variable "metals_prod_ship5y"), its p-value, as well
//as its t-statistic. The F-statistic reported in Table 3 of the paper 
//is the square of the t-statistic of metals_prod_ship5y in the log file. 
do "$dirdofiles/projections_EnglandIV_3y_1700.do"


***Figure 15
do "$dirdofiles/projections_placebo_1700.do" 



***Figure 16 and Table 4
//Note: 
//Results for Table produced in "Table4.log". Log-file contains two tables.
//First output table in log file entitlted "First-stage regressions" gives the
//reported coefficients (lags of  "temperature"),  p-values. 
//The F-statistic as well as Prob > F is reported at the top of the table output.
do "$dirdofiles/projections_reversecausality_GDPIV_1700.do" 



*End of do-file.