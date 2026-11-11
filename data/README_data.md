# Data Dictionary — Palma (2022) Replication Data

## Source

All data originates from the replication package for:

> Palma, N. (2022). "The Real Effects of Monetary Expansions: Evidence from a Large-scale Historical Experiment." *Review of Economic Studies*, 89(3), 1593–1627.

**Zenodo DOI:** <https://doi.org/10.5281/zenodo.5338362> (version 4 of conceptual DOI 10.5281/zenodo.4727681)

The original Stata `.dta` files were converted to CSV for use in Python. The original files are `liquidity.dta` (main panel) and `datadescriptive.dta` (precious metals production and mint output).

---

## Files

### `palma2022_panel.csv`

The main panel dataset used for all regression analysis. 1,560 observations = 6 countries × 260 years.

| Column | Original Stata Name | Description | Unit |
|--------|-------------------|-------------|------|
| `year` | `year` | Year of observation | Integer (1531–1790) |
| `country` | `country` | Country name | String: England/GB, Holland, Italy, Portugal, Spain, Germany |
| `cnumber` | `cnumber` | Numeric country identifier | 1=England, 2=Italy, 3=Holland, 4=Portugal, 5=Spain, 6=Germany |
| `nominal_gdp_index` | `Nominal_GDPindex1700100` | Nominal GDP index | Index (1700 = 100) |
| `price_level_index` | `GDP_deflatorpricelevelinde` | GDP deflator / price level index | Index (1700 = 100) |
| `cpi_silver_index` | `cpi_gramssilverindex1700100` | CPI measured in grams of silver | Index (1700 = 100) |
| `real_gdp_index` | `realGDPindex1700100` | Real GDP index | Index (1700 = 100) |
| `precious_metals_prod_raw` | `pmetals_full1` | Raw precious metals production in the Americas | Tonnes (silver-equivalent) |
| `war_with_spain` | `warspain` | Indicator: country at war with Spain | 0/1 dummy |
| `temperature` | `temperature` | European temperature anomaly (from Guiot & Corona 2010) | Degrees Celsius deviation |
| `ln_real_gdp` | `ln_realGDP` | Log of real GDP index | Natural log |
| `ln_price` | `lnprice` | Log of price level index | Natural log |
| `ln_nominal_gdp` | `lnnominal` | Log of nominal GDP index | Natural log |
| `ln_money_stock` | `lnmoneystock` | Log of European money stock | Natural log |
| `metals_prod` | `metals_prod` | **Shock variable (log):** log of precious metals production as share of European stock | Log ratio |
| `metals_prod_ship` | `metals_prod_ship` | **Main shock variable:** same as metals_prod but adjusted for shipping disruptions (shipwrecks) | Log ratio |
| `metals_prod_ship5y` | `metals_prod_ship5y` | Shock variable: 5-year moving average version (used for England IV analysis) | Log ratio |
| `metals_nologs` | `metals_nologs` | Precious metals production as share of European stock (NOT in logs) | Ratio (0–1) |
| `metals_nologs_ship_nocombat` | `metals_nologs_shipnotcombat` | Same as metals_nologs but adjusted for shipping/combat losses | Ratio (0–1) |
| `cottington` | `cottington` | Cottington variable (instrument, England only) | Float (mostly NaN for non-England) |
| `ln_mint_adj` | `ln_mint_adj` | Log of mint output (England only) | Natural log (NaN for non-England) |
| `ln_mint_adj2` | `ln_mint_adj2` | Log of mint output, adjusted (England only) | Natural log (NaN for non-England) |

**Key analysis variables for local projections (Figure 9 of the paper):**

- Dependent variables: `ln_real_gdp`, `ln_price`, `ln_nominal_gdp`
- Shock variable: `metals_prod_ship` (this is the `$shock` global in Stata)
- Controls: lags of dependent variable, `temperature`, `war_with_spain`, country fixed effects (`cnumber`), time trends

### `palma2022_descriptive.csv`

Additional descriptive data for figures about precious metals production and mint output. 311 observations (single time series, 1500–1810).

| Column | Original Stata Name | Description | Unit |
|--------|-------------------|-------------|------|
| `year` | `year` | Year of observation | Integer (1500–1810) |
| `holland_mint_silver` | `Hollandmintoutputinsilverun` | Holland mint output in silver units | Silver units |
| `france_mint_silver` | `Francemintoutputinsilveruni` | France mint output in silver units | Silver units |
| `genoa_mint_silver` | `Genoamintoutputinsilverunit` | Genoa mint output in silver units | Silver units |
| `innovation` | `innovation` | Innovation component of gold arrivals | Index |
| `silver_prod_tonnes` | `tnssilvernew` | Silver production in Americas | Tonnes of fine silver |
| `gold_prod_tonnes` | `tnsgoldnew` | Gold production in Americas | Tonnes of fine gold |
| `total_prod_tonnes` | `tnstotalnew` | Total production in silver equivalent | Tonnes of silver equivalent |
| `gold_share` | `goldshare` | Share of gold in total production | Proportion (0–1) |
| `potosi_silver_tonnes` | `silvertonspotosi` | Potosí mine silver output | Tonnes of fine silver |
| `potosi_chart_top` | `top` | Chart formatting constant (=200) | Constant |
| `england_mint_millions` | `englandmintmillions` | England mint output | Millions of £ |

---

## Coverage

- **Panel data:** 6 countries × 260 years = 1,560 observations (balanced, no missing values in key columns)
- **Descriptive data:** 311 years (1500–1810), single time series with some NaN in early years
- **Countries:** England/GB, Holland, Italy (north/central), Spain, Portugal, Germany

## Missing Values

- **Panel (`palma2022_panel.csv`):** Zero missing values in all key analysis columns (GDP, prices, metals shock). `cottington`, `ln_mint_adj`, and `ln_mint_adj2` are NaN for non-England countries (1,300 of 1,560 rows).
- **Descriptive (`palma2022_descriptive.csv`):** Some NaN in early years (pre-1530) for silver/gold production and mint data.

## GDP and Price Sources (by country)

| Country | GDP Source | Price Source |
|---------|-----------|-------------|
| England | Broadberry et al. (2015) | Allen (2001) |
| Holland | van Zanden & van Leeuwen (2012) | van Zanden (2005) |
| Italy | Malanima (2011) | Malanima (2011) |
| Spain | Álvarez-Nogal & Prados de la Escosura (2013, 2017) | Hamilton (1934) |
| Portugal | Palma & Reis (2019) | Palma & Reis (2019) |
| Germany | Pfister (2020) | Pfister (2020) |

## Precious Metals Sources

- TePaske (2010), Jara (1963, 1966) — production data
- Barret (1990) — bimetallic ratios for gold-to-silver conversion
- Velde & Weber (2000), Palma (2019) — European stock estimates

## Citation

```text
Palma, N. (2022). The Real Effects of Monetary Expansions: Evidence
from a Large-scale Historical Experiment. Review of Economic Studies,
89(3), 1593–1627. https://doi.org/10.1093/restud/rdab042
```
