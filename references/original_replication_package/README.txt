
A. OVERVIEW
This folder contains the data and do-files that accompany the paper “The real effects of monetary expansions: evidence from a large-scale historical experiment” by Nuno Palma. The replication materials contain this README file; a "MASTER.do" file; two STATA dataset within the "data" folder ("liquidity.dta", used for the main analysis, and "datadescriptive.dta", used for some additional descriptive figures); eleven do-files within the "dofiles" folder; an "output" folder for the Figures and tables generated using the dofiles; and an "additional_figs_tables" folder that contains one figure and two tables that are used in the paper but not generated using these dofiles. The do-file "MASTER.do" completes the analysis for the main body of the text by executing each of the eleven do-files that are necessary for the analysis. Each of the files can also be run separately through the "MASTER.do" file.  The replicator should expect the code for the "MASTER.do" to run for less than 10 minutes on a typical 2021 computer.  

B. DATA AVAILABILITY AND PROVENANCE STATEMENT:
The paper uses two types of data:

1) For outcomes and control variables, the data is available from the secondary literature and was either taken from publicly available websites where the authors deposited their data or given to the Author directly by the authors. GDP and prices come from the following sources: England from Broadberry et al. (2015), Holland from van Zanden and van Leeuwen (2012), Spain from Álvarez-Nogal and Prados de la Escosura (2013, 2017), Italy from Malanima (2011), Portugal from Palma and Reis (2019) and Germany from Pfister (2020). When the original price level was in silver it was transformed into monetary units using the information given by Karaman et al. (2020). Temperature data was made available to the Author by Noel Johnson, one of the authors of Anderson et al. (2017), who in turn rely on the Guiot and Corona (2010) dataset. The indicator about whether a country is at war with Spain is from Clodfelter (2008). The shipwrecks dataset is from Brzezinski et al. (2019). England’s nominal mint output from Challis (1992) and Palma (2018a,b). With regards to the innovation component of gold arrivals, it is built using Costa et al. (2013) and Morineau (2009) as explained in the text.

2) Data collected by the Author. With respect to the main causal variable, the data was collected from the printed information in TePaske (2010) and Jara (1963, 1966), following the procedure explained in detail in the paper. Gold kilograms were translated to silver using Barret (1990, p. 238).

C. STATEMENT ABOUT RIGHTS
The authors of the manuscript have legitimate access to and permission to use the data used in this manuscript.

D. DATASET LIST
The replication material consist of two datasets: "liquidity.dta" and "datadescriptive.dta". "liquidity.dta" is the main datafile which is used for the analysis and contains all variables used in the regression analysis. "datadescriptive.dta" contains some additional variables which is used for the desciptive figures compiled in "descriptive_additionalfigures.do". The sources for this data are described above in section B. of this README file and in the paper.

E. SOFTWARE REQUIREMENTS
The replication requires the use of STATA. The code was run using STATA/SE 16.  As noted in the dofile, two packages must be installed in order to run the "MASTER.do" file: labutil and estout. The code for installing this additional package is at the top of the dofile.

F. MEMORY AND APPROXIMATE RUNTIME REQUIREMENTS
The approximate time needed to reproduce the main analysis ("MASTER.do") using a standard 2021 computer is less than 10 minutes.

G. DESCRIPTION OF PROGRAMS
There is one master do-file "MASTER.do" (described in point G.1) and eleven main dofiles (described in G.2-G.12). 
For a full list of Figures and tables in order of appearance in the paper, see section H. of this README file.

G.1 MASTER.do
This do-file conducts the analysis for the paper (excluding the Online appendix). It first defines the directories and global macros used in the other files, including the main variables for the analysis and the robustness checks. It then links to all the other do-files and performs the analysis of these. This master file clearly explains what analysis is being conducted in each of the files that it links to. Each of the do-files that it links to is now listed below, in order of appearance in the MASTER.do file.

G.2 descriptive_figures.do 
This do-file produces figures 4, 5, 6, and 8 from section 2.3 of the paper and saves them in the "output" folder. 

G.3 descriptive_additionalfigures.do
This do-file produces figures 2, 3, 7, and 11, 12 and 17, located in different sections of the paper and saves them in the "output" folder. 

G.4 projections_main_1700.do
This do-file produces Figure 9 from section 3.1 of the paper and saves them in the "output" folder. 

G.5 projections_countries_1700.do
This do-file produces Figure 10 from section 3.2 of the paper and saves them in the "output" folder. 

G.6 projections_EnglandIV_baseline_1700.do
This do-file produces Figures 13 and 14 as well as the results for Table 3, column 1, from section 3.4 of the paper and saves them in the "output" folder. Results for Column 1 of Table 3 are saved as "Table3_Column1.log" in the "output" folder. The log-file contains two tables: the first output table in the log file entitled "First-stage regressions" gives the reported coefficient (first lag of "metals_prod_ship5y"), standard error, p-value, as well as its t-statistic. The F-statistic reported in Table 3 of the paper is the square of the t-statistic of metals_prod_ship5y in the log file.

G.7 projections_EnglandIV_lag0_1700.do
This do-file produces the results for Table 3, column 2, in section 3.4.
Results for Column 2 of Table 3 are saved as "Table3_Column2.log" in the "output" folder. The log-file contains two tables: the first output table in the log file entitled "First-stage regressions" gives the reported coefficient ("metals_prod_ship5y"), standard error, p-value, as well as its t-statistic. The F-statistic reported in Table 3 of the paper is the square of the t-statistic of metals_prod_ship5y in the log file. 

G.8 projections_EnglandIV_lag2_1700.do
This do-file produces the results for Table 3, column 3, in section 3.4.
Results for Column 3 of Table 3 are saved as "Table3_Column3.log" in the "output" folder. The log-file contains two tables: the first output table in the log file entitled "First-stage regressions" gives the reported coefficient (second lag of "metals_prod_ship5y"), standard error, p-value, as well as its t-statistic. The F-statistic reported in Table 3 of the paper  is the square of the t-statistic of metals_prod_ship5y in the log file. 

G.9 projections_EnglandIV_nocott_1700.do
This do-file produces the results for Table 3, column 4, in section 3.4.
Results for Column 4 of Table 3 are saved as "Table3_Column4.log" in the "output" folder. The log-file contains two tables: the first output table in the log file entitled "First-stage regressions" gives the reported coefficient (variable "metals_prod_ship5y"), standard error, p-value, as well as its t-statistic. The F-statistic reported in Table 3 of the paper  is the square of the t-statistic of metals_prod_ship5y in the log file. 

G.10 projections_EnglandIV_3y_1700.do
This do-file produces the results for Table 3, column 5, in section 3.4.
Results for Column 5 of Table 3 are saved as "Table3_Column5.log" in the "output" folder. The log-file contains two tables: the first output table in the log file entitled "First-stage regressions" gives the reported coefficient (variable "metals_prod_ship5y"), standard error, p-value, as well as its t-statistic. The F-statistic reported in Table 3 of the paper is the square of the t-statistic of metals_prod_ship5y in the log file.

G.11 projections_placebo_1700.do
This do-file prepares figure 15 from section 4.2.

G.12 projections_reversecausality_GDPIV_1700.do
This do-file prepares the information for Table 4 and Figure 16 from section 4.3.
Results for the table are saved as "Table4.log" in the "output" folder. The log-file contains two tables: The first output table in the log file entitled"First-stage regressions" gives the reported coefficients (lags of  "temperature"), standard errors and  p-values. The F-statistic as well as Prob > F is reported at the top of the table output.

H. FULL LIST OF TABLES AND FIGURES

H.1 FIGURES ARE GENERATED BY THE FOLLOWING DO-FILES

Figure 1: The map is created based on the sources listed in the paper. It is not directly generated within the code. The figure can be found in the "additional_figs_tables" folder ("PortugueseAtlanticempire_SemLimites.png")
Figure 2: The figure is generated in descriptive_additionalfigures.do, saved as "pmetals_goldsilver.png".
Figure 3: The figure is generated in descriptive_additionalfigures.do, saved as "potosiamalgamation.png"
Figure 4: The figure is generated in descriptive_figures.do, saved as "nominal_descriptive.png"
Figure 5: The figure is generated in descriptive_figures.do, saved as "prices_descriptive.png" 
Figure 6: The figure is generated in descriptive_figures.do, saved as "real_descriptive.png"
Figure 7: The figure is generated in descriptive_additionalfigures.do, saved as "goldandsilver.png"
Figure 8: The figure is generated in descriptive_figures.do, saved as  "metals_descriptive.png"
Figure 9: The figure is generated in projections_main_1700.do, saved as "projections_main_1700.png" 
Figure 10: The figure is generated in projections_countries_1700.do, saved as "projections_countries_real_1700.png"
Figure 11: The figure is generated in descriptive_additionalfigures.do, saved as "HOLLANDfrancemint.png"
Figure 12: The figure is generated in descriptive_additionalfigures.do, saved as "ENGLANDmint.png"
Figure 13: The figure is generated in projections_EnglandIV_baseline_1700.do, saved as "england_firststage_figure.png"
Figure 14: The figure is generated in projections_EnglandIV_baseline_1700.do, saved as "projections_engIV_base.png"
Figure 15: The figure is generated in projections_placebo_1700.do, saved as "projections_placebo_1700_real.png"
Figure 16: The figure is generated in projections_reversecausality_GDPIV_1700.do, saved as "projection_1700_reverse_GDPIV.png"
Figure 17: The figure is generated in descriptive_additionalfigures.do, saved as "INNOV.png"

H.2 TABLES ARE GENERATED BY THE FOLLOWING DO-FILES

Table 1: The information for this table is directly copied from the sources listed in the paper. Thus, this table is not generated within the code. The table can be found in the "additional_figs_tables" folder ("table1.tex").
Table 2: The information for this table is directly copied from the sources listed in the paper. Thus, this table is not generated within the code. The table can be found  in the "additional_figs_tables" folder ("table2.tex").
Table 3: The information for the columns ofthis table are generated separately in the files projections_EnglandIV_baseline_1700.do (Column 1), projections_EnglandIV_lag0_1700.do (Column 2), projections_EnglandIV_lag2_1700.do (Column 3), projections_EnglandIV_nocott_1700.do (Column 4), and projections_EnglandIV_3y_1700.do (Column 5). The information for each column is saved separately as "Table3_col1.log", Table3_col2.log", "Table3_col3.log", "Table3_col4.log" and "Table3_col5.log", respectively. 
Table 4: The information for this table is generated in projections_reversecausality_GDPIV_1700.do, saved as "Table4.log."

I. INSTRUCTIONS TO REPLICATORS:
The instructor should open the "MASTER.do" file and first change the directories there (or alternatively leave the default directories), as explained in the do-file. Then, the replicator should run the "MASTER.do" file to produce all figures as well as the information required for the tables. By default, the figures will be produced in the folder where the datasets are located, but the replicator can change this at the top of the "MASTER.do" file, as is clearly explained in the file. If desired, the replicator can also separately run each code segment from the "MASTER.do" file.

J. REFERENCES USED IN THIS README FILE

Álvarez-Nogal, C. and Prados de la Escosura, L. (2013). The rise and fall of Spain (1270-1850). The Economic History Review, 66(1):1–37 

Álvarez-Nogal, C. and Prados de la Escosura, L. (2017). Long-run GDP estimates for Spain, 1277-1850 (2017). Unpublished manuscript

Anderson, R. W., Johnson, N. D., and Koyama, M. (2017). Jewish persecutions and weather shocks: 1100–1800. The Economic Journal, 127(602):924–958

Barret, W. (1990). World bullion flows, 1450-1800. In: The Rise of Merchant Empires. Cambridge University Press

Brzezinski, A., Chen, Y., Palma, N., and Ward, F. (2019). The vagaries of the sea: evidence on the real effects of money from maritime disasters in the Spanish Empire. CEPR Discussion Paper 14089  

Broadberry, S., Campbell, B., Klein, A., Overton, M., and van Leeuwen, B. (2015). British Economic Growth, 1270-1870. Cambridge University Press

Challis, C. (1992). Lord Hastings to the great silver recoinage 1464-1699. In Challis, C., editor, New History of the Royal Mint. Cambridge University Press.

Clodfelter, M. (2008). Warfare and armed conflicts: a statistical reference to casualty and other figures 1494-2007. McFarland

Costa, L. F., Rocha, M. M., and Sousa, R. O Ouro do Brasil. Imprensa Nacional-Casa da Moeda, 2013.

Guiot, J. and Corona, C. (2010). Growing season temperatures in Europe and climate forcings over the past 1400 years. PLoS One, 5(4). URL: www.ncdc.noaa.gov/paleo/recons.html

Jara, A. (1963). La producción de metales preciosos en el Perú en el siglo XVI. Boletín de la Universidadde Santiago de Chile 44

Jara, A. (1966). Tres Ensayos sobre Econom´ia Minera Hispanoamericana. Santiago de Chile: Prensas de la editorial universitaria, S. A.

Karaman, K. K., Pamuk, S., & Yildirim-Karaman, S. (2020). Money and monetary stability in Europe, 1300–1914. Journal of Monetary Economics, 115, 279-300.  

Malanima, P. (2011). The long decline of a leading economy: GDP in central and northern Italy, 1300-1913. European Review of Economic History, 15:169–219, 2011.

Morineau, M. (2009). Incroyables Gazettes et Fabuleux Métaux: Les Retours des Trésors Américains d’Après les Gazettes Hollandaises (XVI-XVII Siècles). Cambridge University Press.

Palma, N. (2018a). Reconstruction of money supply over the long run: the case of England, 1270-1870. The Economic History Review, 71(2):373–392

Palma, N. (2018b).  Money and modernization in early modern England. Financial History Review, 25 (3):231–261

Palma, N. and J. Reis (2019). From convergence to divergence: Portuguese economic growth, 1527-1850 Journal of Economic History 79 (2): 477-506 

Palma, N. (2021, forthcoming). The real effects of monetary expansions: evidence from a large-scale historical experiment. Review of Economic Studies.

Pfister, U. (2020). Economic Growth in Germany, 1500-1800. Unpublished manuscript

TePaske, J. A New World of Gold and Silver. Brill, 2010.

van Zanden, J. L. and van Leeuwen (2012). Persistent but not consistent: The growth of national income in Holland 1347-1807. Explorations in Economic History, 49:119–130


